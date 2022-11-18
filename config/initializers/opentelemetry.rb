require 'codecov_opentelem'

OpenTelemetry::SDK.configure do |c|
    current_env = ENV['CODECOV_OPENTELEMETRY_ENV'] || 'production'
    current_version = ENV['CURRENT_VERSION'] || '0.0.1'
    # export_rate: Percentage of spans that are sampled with execution data.
    # Note that sampling execution data does incur some performance penalty,
    # so 10% is recommended for most services.
    # Values should be between 0 and 1.
    export_rate = 1

    # untracked_export_rate: Currently unused.
    # Percentage of spans that are sampled without execution data.
    # These spans incur a much smaller performance penalty, but do not provide
    # as robust a data set to Codecov, resulting in some functionality being
    # limited.
    # Values should be between 0 and 1.
    untracked_export_rate = 0

    generator, exporter = get_codecov_opentelemetry_instances(
        repository_token: '0794ef7c-f574-4d04-a9c3-fb93e0c75ece',
        sample_rate: export_rate,
        untracked_export_rate: untracked_export_rate,
        code: "#{current_version}:#{current_env}",
        filters: {
            'file_ignore_regex'=>/\/gems\//,
        },
        version_identifier: current_version,
        environment: current_env,
    )

    c.add_span_processor(generator)
    c.add_span_processor(OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(exporter))
end
