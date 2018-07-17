require 'securerandom'

class AgreementsController < ApplicationController

  def new
    @agreement_template = AgreementTemplate.first
    @chapters = Chapter.all
    @agreement = Agreement.new
  end

  def create
    @agreement = Agreement.create(agreement_params)
    answer_ids = params[:agreement][:agreement_answer][:answer]
    answer_ids.select(&:present?).each do |id|
      answer = Answer.find(id)
      AgreementAnswer.create(agreement: @agreement, answer: answer)
    end
    # Create all the AgreementAnswer from the answer selected
    redirect_to agreement_url(@agreement)
  end

  def show
    @agreement = Agreement.find(params[:id])
    build_and_send_docx
  end

  def all_answers_pool
    @answers = Answer.all
  end

  def build_and_send_docx

    file = "/tmp/" + SecureRandom.uuid + ".docx"

    Caracal::Document.save(file) do |docx|

      docx.img 'https://hk2-startup.de/wp-content/uploads/2014/11/HK2_LOGO_300dpi.jpg', width: 100, height: 150
      4.times do
        docx.p
      end
      docx.p Date.today.strftime('%B %d, %Y'), color: '666666', align: :right
      docx.h3 "Kontaktdaten"
      docx.p "Firma: #{@agreement.company}"
      docx.p "Telefon: #{@agreement.phone}"
      docx.p "Mail: #{@agreement.mail}"
      docx.p "Vertragtitel: #{@agreement.name}"
      docx.p "VertragsID: #{@agreement.id}"

      5.times do
        docx.p
      end

      docx.hr
      docx.p "just for testing"
      docx.p "#{@agreement.answer_ids}"
      docx.hr
      docx.p


      docx.h3 "Bitte beachten:"
      docx.hr
      all_answers_pool # specific answers will be shown in red, cause they are dangarous - we need answers_id that doesnt change
      all_answers_ids = @answers.ids
      dangarous_answers = [3, 6] #  manual input of dangarous answers ids.

      all_answers_ids & dangarous_answers

      Answer.find(@agreement.answer_ids).each do |a|
        docx.p a.sentence
      end


      docx.hr

      docx.hr
      docx.p "just for testing"
      docx.p "#{@agreement.answer_ids}"
      docx.hr

      docx.h2 'Technische und Organisatorische Maßnahmen nach Art. 32 DSGVO'
      docx.h3 "Verschlüsselung und Pseudonymisierung personenbezogener Daten"
      docx.p
    # raise
    #

  end

  UserMailer.report("." + file).deliver_now
end

private

def agreement_params
  params.require(:agreement).permit(:name, :phone, :mail, :company, :id)
end

end
