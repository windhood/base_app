def load_config_yaml filename
  YAML.load(File.read(filename))
end

oauth_keys_file = "#{Rails.root}/config/oauth_keys.yml"


SERVICES = nil
silence_warnings do
  if File.exist? oauth_keys_file
    SERVICES = load_config_yaml(oauth_keys_file)
  else
    SERVICES = load_config_yaml("#{oauth_keys_file}.example")
  end
end