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

  def build_and_send_docx
    file = "/tmp/" + SecureRandom.uuid + ".docx"

    Caracal::Document.save(file) do |docx|

     docx.img 'https://hk2-startup.de/wp-content/uploads/2014/11/HK2_LOGO_300dpi.jpg', width: 100, height: 150
     4.times do 
      docx.p
    end
    docx.p Date.today.strftime('%B %d, %Y'), color: '666666', align: :right
    docx.h3 "Kontaktdaten"
    docx.p "Firma: #{@agreement.comapny}"
    docx.p "Telefon: #{@agreement.phone}"
    docx.p "Mail: #{@agreement.mail}"
    docx.p "Vertrag: #{@agreement.name}"

    5.times do 
      docx.p
    end

    docx.h2 'Technische und Organisatorische Maßnahmen nach Art. 32 DSGVO'
    Answer.find(@agreement.answer_ids).each do |a|
      docx.p a.sentence
    end
    # docx.h2 @agreement.answer_ids
      # raise
    end

    UserMailer.report("." + file).deliver_now
  end

  private

  def agreement_params
    params.require(:agreement).permit(:name, :phone, :mail, :comapny)
  end

end
