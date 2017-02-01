module EventsHelper

  def users_role
    Event.user_roles
  end

  def gigs_type
    Event.type_of_gigs
  end

  def time_diff_for_post(post)
    seconds = (TimeDifference.between(Time.now,post.created_at).in_seconds.to_i)
    mm, ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
  end

  def volunteers_works_hours(event)
    seconds = (TimeDifference.between(event.event_start_time,event.event_end_time).in_seconds.to_i)
    mm, ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
  end
end
