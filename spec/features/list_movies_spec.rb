require "rails_helper"

describe "Viewing root page" do
  it "shows the menu at top" do
    visit movies_url # 'visit' is a capybara thing

    # 'page' is a capybara-provided object
    expect(page).to have_text("Released")
    expect(page).to have_text("Upcoming")
    expect(page).to have_text("Recent")
    expect(page).to have_text("Hits")
    expect(page).to have_text("Flops")
  end
end
