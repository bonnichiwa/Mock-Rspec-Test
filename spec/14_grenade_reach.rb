require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @grenade = Grenade.new
  end
 
  describe '#attack' do
    context "equipped with grenade" do
      before :each do
        @robot.equipped_weapon = @grenade
      end
 
      context "with enemy robot two blocks above" do
        before :each do
          @robot2 = Robot.new
          @robot2.move_up
          @robot2.move_up
        end
 
        it "is able to successfully wound the enemy" do
          expect(@robot2).to receive(:wound)
          @robot.attack(@robot2)
        end
 
        it "should dispense the weapon (can only use once)" do
          @robot.attack(@robot2)
          expect(@robot.equipped_weapon).to be_nil
        end
      end
 
      context "with enemy robot three blocks above" do
        before(:each) do
          @robot2 = Robot.new
          @robot2.move_up
          @robot2.move_up
          @robot2.move_up
        end
 
        it "is NOT able to successfully wound the enemy" do
          expect(@robot2).not_to receive(:wound)
          @robot.attack(@robot2)
        end
      end
    end
  end
end