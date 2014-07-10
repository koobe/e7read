package kgl

import org.springframework.web.multipart.MultipartHttpServletRequest

class FileUploadFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                if (request instanceof MultipartHttpServletRequest) {
                    def multipleFileMap = request.multiFileMap
                    multipleFileMap.each { fieldName, files ->
                        if (files.size() == 1) {
                            params.put(fieldName, files.first())
                        }
                        else {
                            params.put(fieldName, files)
                        }
                    }
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
