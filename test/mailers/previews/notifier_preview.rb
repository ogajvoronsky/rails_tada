class NotifierPreview < ActionMailer::Preview
  def statistic
    statistic = Hash(completed: 7, remaining: 3)
    @daily_statistic = DailyStatisticNotifier.new statistic
    Notifier.statistic @daily_statistic
  end
end