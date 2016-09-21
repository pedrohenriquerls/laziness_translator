require "yandex-translator"
require 'yaml'
require 'byebug'

namespace :translator do
  desc 'set positions on actions by created_at'
  task :create_new_i18n_file, [:i18n_file, :language_code] do |t, args|
    i18n_file  = YAML::load_file args[:i18n_file]
    translator = Yandex::Translator.new(ENV['YANDEX_API_KEY'])

    language_code = args[:language_code]
    translated_hash = {}


    i18n_file.values.first.each do |key, value|
      if value.is_a? String
        translated_hash[key] = translator.translate value, from: 'pt', to: language_code
      else
        translate_hash(key, value, translator, translated_hash, language_code)
      end
    end

    File.open("new_i18n_file.yml", "w") do |file|
      new_i18n_file = {}
      new_i18n_file[language_code.to_sym] = translated_hash
      file.write new_i18n_file.to_yaml
    end
  end
end

def translate_hash(parent, hash, translator, new_hash, language_code)
  hash.each do |key, value|
    if value.is_a?(Hash)
      new_hash[key] = {}
      translate_hash(key, value, translator, new_hash[key], language_code)
    else
      new_hash[key] = translator.translate value, from: 'pt', to: language_code
    end
  end
end
