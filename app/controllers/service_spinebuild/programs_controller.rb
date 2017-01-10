class ServiceSpinebuild::ProgramsController < ServiceSpinebuild::BaseController
  before_action :spinebuild_programs

  def spinebuild_programs
    @spine = LongProgram.where(identity_card: User.find_by(id: current_user.user_id).identity_card)
  end

  def program_item
    @spine_program = @spine.where(recipe_number: params[:format])
  end
end
