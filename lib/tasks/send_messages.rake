namespace :messages do
  desc "Enviar mensajes de correo encolados"
  task(:send => :environment) do
    # Mirar si hay tareas funcionando
    unless Task.find(1).working
      # Marcamos la tarea como ejecutandose
      task = Task.find(1)
      task.working = true
      task.save
      # Mensajes que no han sido mandados
      messages = Message.all(:conditions => ["sent = ? AND active = ?", false, true])
      if messages.size > 0
        messages.each do |message|
          # Marcamos el mensaje como enviado
          message.sent = true
          message.save
          recipients = Recipient.all(:conditions => ["lang = ?", message.lang])
          emails = []
          recipients.each do |r|
            emails << r.email
          end
          # Enviamos el mensaje
          Mailer.deliver_send_mail(message, recipients)
          # Paramos unos segundos para que no nos filtren
          sleep(15)
        end
      end
      # Marcar la tarea como terminada
      task = Task.find(1)
      task.working = false
      task.save
    end
  end
end
