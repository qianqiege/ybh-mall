class ServiceSpinebuild::ProgramsController < ServiceSpinebuild::BaseController

  def spinebuild_programs
    @spine = LongProgram.where(identity_card: User.find_by(id: current_user.user_id).identity_card)
  end
end
