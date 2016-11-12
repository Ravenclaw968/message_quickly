module MessageQuickly
  module Messaging
    class VideoAttachment < Attachment

      attr_accessor :url, :file, :file_type, :is_reusable, :attachment_id

      def initialize(params = {})
        params['type'] ||= 'video'
        params['is_reusable'] ||= false
        super(params)
      end

      def file?
        file.present? && file_type.present?
      end

      def to_hash
        return { type: type, payload: { attachment_id: attachment_id } } if attachment_id
        if file?
          { type: type, payload: { url: '', is_reusable: is_reusable } } # cannot send empty hash
        else
          { type: type, payload: { url: url, is_reusable: is_reusable } }
        end
      end

    end
  end
end

# "attachments":[
#   {
#     "type":"video",
#     "payload":{
#       "url":"https://petersapparel.com/bin/clip.mp4"
#     }
#   }
# ]

# curl  \
#   -F recipient='{"id":"USER_ID"}' \
#   -F message='{"attachment":{"type":"video", "payload":{}}}' \
#   -F filedata=@/tmp/clip.mp4;type=video/mp4 \
#   "https://graph.facebook.com/v2.6/me/messages?access_token=PAGE_ACCESS_TOKEN"