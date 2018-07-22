# frozen_string_literal: true

Array.wrap(command_options).each do |factory_options|
  factory_method = factory_options.shift
  begin
    logger.debug "running #{factory_method}, #{factory_options}"
    CypressDev::SmartFactoryWrapper.public_send(factory_method, *factory_options)
  rescue StandardError => e
    logger.error "#{e.class}: #{e.message}"
    logger.error e.backtrace.join("\n")
    raise e
  end
end
