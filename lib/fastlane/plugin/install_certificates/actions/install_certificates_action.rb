require 'fastlane/action'
require_relative '../helper/install_certificates_helper'

module Fastlane
  module Actions
    class InstallCertificatesAction < Action
      def self.run(params)
        UI.important("Installing certificates")
        certificates = locate_certifcates

        if certificates.count ==  0
          UI.success("No certificates found")
          return
        end

        certificates.each do |certificate|
          # Show the certifcate basename
          UI.message("Certificate: #{File.basename certificate}")

          # Install a certain Certificate
          install_certificate(certificate, params[:passphrase])
        end

        UI.success("Successfully installed certificates")
      end

      def self.locate_certifcates
        Dir.glob("**/*.p12")
      end

      def self.install_certificate(certificate, passphrase)
        `security -i import #{certificate} -P #{passphrase} -T /usr/bin/codesign`
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Install all the certificates located in you're project."
      end

      def self.authors
        ["Dylan Gyesbreghs"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :passphrase,
            env_name: "INSTALL_CERTIFICATES_PASSPHRASE",
            description: "A description of your option",
            optional: true,
            type: String,
            default_value: "")
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
