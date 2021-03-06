# frozen_string_literal: true

module Support
  module Assertions

    class RequestWithoutProtocol < Base
      def call(protocol_to_request:)
        setup(protocol_to_request)

        stub_request(@example_com)
        stub_request(@www_example_com)

        test.assert Func::IsOK.(@request_without_protocol_to.(:example_com))
        test.assert Func::IsOK.(@request_without_protocol_to.(:www_example_com))
      end

      private

      def setup(protocol_to_request)
        routes = Routes::To.(protocol_to_request)
        request = Func::GetRequestViaHTTPMethod.(http_method)

        @example_com = routes.(:example_com)
        @www_example_com = routes.(:www_example_com)
        @request_without_protocol_to = -> host {
          request.(Routes.without_protocol(host))
        }
      end
    end

  end
end
