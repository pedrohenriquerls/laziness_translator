require "yandex-translator"
require 'yaml'
require 'byebug'
require_relative 'progress_bar'

$translator = Yandex::Translator.new(ENV['YANDEX_API_KEY'])
namespace :translator do
  desc 'set positions on actions by created_at'
  task :create_new_i18n_file, [:i18n_file, :language_code] do |t, args|
    puts 'Reading file...'
    i18n_file  = YAML::load_file args[:i18n_file]

    $language_code = args[:language_code]
    translated_hash = {}

    initial_values = i18n_file.values.first
    puts 'Translating your file...'
    i18n_file.each do |key, value|
      translate_hash(key, value, translated_hash)
    end

    File.open("new_i18n_file.yml", "w") do |file|
      new_i18n_file = {}
      new_i18n_file[language_code.to_sym] = translated_hash.values.first
      file.write new_i18n_file.to_yaml
    end
  end
end

def translate_hash(parent, hash, new_hash)
  progress_bar = ProgressBar.new(hash.length, "Key -> #{parent}")
  hash.each do |key, value|
    if value.is_a?(Hash)
      new_hash[key] = {}
      translate_hash(key, value, new_hash[key])
    else
      new_hash[key] = translate(value)
      progress_bar.increment
    end
  end
end

def translate(text, from = 'pt')
  "'#{$translator.translate(text, from: from, to: $language_code)}'"
end
