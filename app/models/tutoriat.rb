class Tutoriat
  def initialize name
    @name = name
  end

  def name
    @name
  end

  def tutoren
    @tutoren ||= Tutor.where(:tutoriat => name).order :zimmernummer
  end

  def email
    @email ||= tutoren.first.try(:mail).try :strip
  end

  def email?
    not email.blank?
  end
end