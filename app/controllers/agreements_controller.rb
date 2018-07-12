class AgreementsController < ApplicationController

  def show
    @agreement = Agreement.find(params[:id])
  end
  def new
    @agreement_template = AgreementTemplate.first
    @agreement = Agreement.new
  end

  def create
    @agreement = Agreement.create(agreement_params)
    answer_ids = params[:agreement][:agreement_answer][:answer]
    answer_ids.select(&:present?).each do |id|
      answer = Answer.find(id)
      AgreementAnswerr.create(agreement: @agreement, answer: answer)
    end
    # Create all the AgreementAnswer from the answer selected
  end

  private

  def agreement_params
    params.require(:agreement).permit(:name)

  end
end
