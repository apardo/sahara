namespace :admin do
  desc "Introducir contactos desde un fichero"
  task(:entercontacts => :environment) do
    # Fichero con los contactos
    data = ENV['FILENAME']
    # Lenguaje del contacto
    lang = ENV['LANG']

    # Abrir el fichero con los contactos
    file = File.open(data)
    # Leer línea a línea
    file.each_line {|line|
      recipient = Recipient.create(:email => line.strip, :lang => lang)
      if recipient.save
        puts "Receptor #{recipient.email} introducido en la DB"
      else
        puts recipient.errors[:email].to_sentence
      end
    }
  end
end
