package kgl

import grails.transaction.Transactional

@Transactional
class ContentService {

    def createEditableHashcode(Content content) {

        if (!content) {
            return
        }

        if (content.editableHashcode) {
            log.info "Content(${content.id}) already has an editableHashcode."
            return content.editableHashcode
        }

        def tokenGenerator = { String alphabet, int n ->
            new Random().with {
                (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
            }
        }

        while (!content.editableHashcode) {
            def token = tokenGenerator((('A'..'Z')+('0'..'9')).join(), 15)

            Hashids hashids = new Hashids("${content.id}-${token}");

            int r1 = new Random().with {nextInt(9)}
            int r2 = new Random().with {nextInt(9)}
            int r3 = new Random().with {nextInt(9)}

            String hash = hashids.encrypt(r1, r2, r3);

            if (Content.countByEditableHashcode(hash) == 0) {
                content.editableHashcode = hash
            }
        }

        content.save flush: true

        return content.editableHashcode
    }
}
