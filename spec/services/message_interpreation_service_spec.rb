require 'rails_helper'

RSpec.describe MessageInterpretationService, type: :model do
  describe '#call' do
    context 'when source_language is FR' do
      FR_TEXT = {
        "Mesdames et messieurs du jury. Les preuves sont concluantes." =>
          "Ladies and gentlemen of the jury. The evidence is conclusive.",

        "Mademoiselle Ancre a vu un homme chauve, correspondant à la description de M. Gris, quitter la section touristique du palais et voler le stylo-plume inestimable du Roi dans sa chambre privée." =>
          "Miss Anchor saw a bald man, matching Mr. Grey’s description, leave the tourist section of the palace, and steal the King’s priceless fountain pen from his private room."
      }
      EN_FR_TEXT = FR_TEXT.invert

      FR_TEXT.each_pair do |fr, en|
        context "when translating '#{fr}'" do
          let!(:english_speaker) { create(:user, :internal) } # Default language is en
          let!(:french_speaker) { create(:user, language: 'FR') }
          let!(:room) { create(:room, assignee_id: english_speaker.id) }
          let!(:room_participant_en) { create(:participant, room: room, user: english_speaker) }
          let!(:room_participant_fr) { create(:participant, room: room, user: french_speaker) }
          let!(:message) { create(:message, source_text: fr, source_language: 'FR', user: french_speaker, room: room) }

          subject(:service) { MessageInterpretationService.new }

          it "translates correctly to '#{en}'" do
            expect(service.call(message)).to eq(en)
          end
        end
      end

      EN_FR_TEXT.each_pair do |en, fr|
        context "when translating '#{en}'" do
          let!(:english_speaker) { create(:user, :internal) } # Default language is en
          let!(:french_speaker) { create(:user, language: 'FR') }
          let!(:room) { create(:room, assignee_id: english_speaker.id) }
          let!(:room_participant_en) { create(:participant, room: room, user: english_speaker) }
          let!(:room_participant_fr) { create(:participant, room: room, user: french_speaker) }
          let!(:message) { create(:message, source_text: en, source_language: 'EN', user: english_speaker, room: room) }

          subject(:service) { MessageInterpretationService.new }

          it "translates correctly to '#{fr}'" do
            expect(service.call(message)).to eq(fr)
          end
        end
      end
    end
  end
end

