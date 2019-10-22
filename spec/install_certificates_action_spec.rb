describe Fastlane::Actions::InstallCertificatesAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The install_certificates plugin is working!")

      Fastlane::Actions::InstallCertificatesAction.run(nil)
    end
  end
end
