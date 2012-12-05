describe DonationClick do
  it { should belong_to :member } 
  it { should belong_to :petition } 
  it { should belong_to :referral_code } 
  it { should allow_mass_assignment_of :member }
  it { should allow_mass_assignment_of :petition }
  it { should allow_mass_assignment_of :referral_code }
  it { should allow_mass_assignment_of :amount }
  it { should validate_presence_of :petition }
  it { should validate_presence_of :member }
  it { should validate_presence_of :referral_code }

  describe '.confirm_payment' do
    let(:donation) { mock }
    let(:donator) { stub }

    before do
      Member.stub(:where).with(:email => 'bob@gmail.com').and_return([donator])
      DonationClick.stub(:where).with(:member_id => donator, :amount => nil).
        and_return([donation])
    end
    
    it 'updates amount' do
      donation.should_receive(:update_attributes).with(:amount => 30.0)
      DonationClick.confirm_payment(30.0, 'bob@gmail.com')
    end
  end
end
