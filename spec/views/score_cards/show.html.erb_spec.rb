require 'spec_helper'

describe "score_cards/show.html.erb" do
  before(:each) do
    @score_card = assign(:score_card, stub_model(ScoreCard,
      :user_id => 1,
      :course_id => 1,
      :tee_box => "Tee Box",
      :course2_id => 1,
      :start_hole => 1,
      :score => 1,
      :hole1_id => 1,
      :score1 => 1,
      :putts1 => 1,
      :t_club1 => "T Club1",
      :fairway1 => "Fairway1",
      :sand1 => 1,
      :pty1 => 1,
      :hole2_id => 1,
      :score2 => 1,
      :putts2 => 1,
      :t_club2 => "T Club2",
      :fairway2 => "Fairway2",
      :sand2 => 1,
      :pty2 => 1,
      :hole3_id => 1,
      :score3 => 1,
      :putts3 => 1,
      :t_club3 => "T Club3",
      :fairway3 => "Fairway3",
      :sand3 => 1,
      :pty3 => 1,
      :hole4_id => 1,
      :score4 => 1,
      :putts4 => 1,
      :t_club4 => "T Club4",
      :fairway4 => "Fairway4",
      :sand4 => 1,
      :pty4 => 1,
      :hole5_id => 1,
      :score5 => 1,
      :putts5 => 1,
      :t_club5 => "T Club5",
      :fairway5 => "Fairway5",
      :sand5 => 1,
      :pty5 => 1,
      :hole6_id => 1,
      :score6 => 1,
      :putts6 => 1,
      :t_club6 => "T Club6",
      :fairway6 => "Fairway6",
      :sand6 => 1,
      :pty6 => 1,
      :hole7_id => 1,
      :score7 => 1,
      :putts7 => 1,
      :t_club7 => "T Club7",
      :fairway7 => "Fairway7",
      :sand7 => 1,
      :pty7 => 1,
      :hole8_id => 1,
      :score8 => 1,
      :putts8 => 1,
      :t_club8 => "T Club8",
      :fairway8 => "Fairway8",
      :sand8 => 1,
      :pty8 => 1,
      :hole9_id => 1,
      :score9 => 1,
      :putts9 => 1,
      :t_club9 => "T Club9",
      :fairway9 => "Fairway9",
      :sand9 => 1,
      :pty9 => 1,
      :hole10_id => 1,
      :score10 => 1,
      :putts10 => 1,
      :t_club10 => "T Club10",
      :fairway10 => "Fairway10",
      :sand10 => 1,
      :pty10 => 1,
      :hole11_id => 1,
      :score11 => 1,
      :putts11 => 1,
      :t_club11 => "T Club11",
      :fairway11 => "Fairway11",
      :sand11 => 1,
      :pty11 => 1,
      :hole12_id => 1,
      :score12 => 1,
      :putts12 => 1,
      :t_club12 => "T Club12",
      :fairway12 => "Fairway12",
      :sand12 => 1,
      :pty12 => 1,
      :hole13_id => 1,
      :score13 => 1,
      :putts13 => 1,
      :t_club13 => "T Club13",
      :fairway13 => "Fairway13",
      :sand13 => 1,
      :pty13 => 1,
      :hole14_id => 1,
      :score14 => 1,
      :putts14 => 1,
      :t_club14 => "T Club14",
      :fairway14 => "Fairway14",
      :sand14 => 1,
      :pty14 => 1,
      :hole15_id => 1,
      :score15 => 1,
      :putts15 => 1,
      :t_club15 => "T Club15",
      :fairway15 => "Fairway15",
      :sand15 => 1,
      :pty15 => 1,
      :hole16_id => 1,
      :score16 => 1,
      :putts16 => 1,
      :t_club16 => "T Club16",
      :fairway16 => "Fairway16",
      :sand16 => 1,
      :pty16 => 1,
      :hole17_id => 1,
      :score17 => 1,
      :putts17 => 1,
      :t_club17 => "T Club17",
      :fairway17 => "Fairway17",
      :sand17 => 1,
      :pty17 => 1,
      :hole18_id => 1,
      :score18 => 1,
      :putts18 => 1,
      :t_club18 => "T Club18",
      :fairway18 => "Fairway18",
      :sand18 => 1,
      :pty18 => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tee Box/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club3/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway3/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club4/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway4/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club6/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway6/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club7/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway7/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club8/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway8/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club9/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway9/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club10/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway10/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club11/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway11/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club12/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway12/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club13/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway13/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club14/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway14/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club15/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway15/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club16/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway16/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club17/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway17/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/T Club18/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fairway18/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
