require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def execute_transaction
    if !self.valid? && @sender.balance <= @amount
      @status = "rejected"
      @status = "Transaction rejected. Please check your account balance."
    elsif @status == "pending"
    BankAccount.all.map do | person |
      if person == @sender
        person.balance -= @amount
      elsif person == @receiver
        person.balance += @amount
      end
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    end
  end
end
