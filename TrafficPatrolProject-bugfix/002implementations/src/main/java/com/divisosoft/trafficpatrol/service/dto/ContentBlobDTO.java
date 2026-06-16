package com.divisosoft.trafficpatrol.service.dto;

import jakarta.persistence.Lob;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.divisosoft.trafficpatrol.domain.ContentBlob} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ContentBlobDTO implements Serializable {

    private Long id;

    @Lob
    private byte[] contentBlob;

    private String contentBlobContentType;
    private ContentDTO content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public byte[] getContentBlob() {
        return contentBlob;
    }

    public void setContentBlob(byte[] contentBlob) {
        this.contentBlob = contentBlob;
    }

    public String getContentBlobContentType() {
        return contentBlobContentType;
    }

    public void setContentBlobContentType(String contentBlobContentType) {
        this.contentBlobContentType = contentBlobContentType;
    }

    public ContentDTO getContent() {
        return content;
    }

    public void setContent(ContentDTO content) {
        this.content = content;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ContentBlobDTO)) {
            return false;
        }

        ContentBlobDTO contentBlobDTO = (ContentBlobDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, contentBlobDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ContentBlobDTO{" +
            "id=" + getId() +
            ", contentBlob='" + getContentBlob() + "'" +
            ", content=" + getContent() +
            "}";
    }
}
