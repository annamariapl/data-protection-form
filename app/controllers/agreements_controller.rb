require 'securerandom'

class AgreementsController < ApplicationController

  def new
    @agreement_template = AgreementTemplate.first
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
      docx.page
      docx.h1 'Introduction'
      docx.hr
      docx.h2 'Overview'
      docx.p 'Caracal is a pure Ruby library for generating dynamic Microsoft Word documents. While the library does not support the entire Open XML specification, most common Word features are available.'
      docx.p
      docx.p 'Major features include:'
    end

    UserMailer.report("." + file).deliver_now
  end

  private

  def agreement_params
    params.require(:agreement).permit(:name)
  end

end
