module EventsHelper

  def users_role
    Event.user_roles
  end

  def gigs_type
    Event.type_of_gigs
  end
end
