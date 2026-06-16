package com.divisosoft.trafficpatrol.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A ContentBlob.
 */
@Entity
@Table(name = "content_blob")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ContentBlob implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Lob
    @Column(name = "content_blob")
    private byte[] contentBlob;

    @Column(name = "content_blob_content_type")
    private String contentBlobContentType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "contentBlobs", "violations", "appUser" }, allowSetters = true)
    private Content content;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public ContentBlob id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public byte[] getContentBlob() {
        return this.contentBlob;
    }

    public ContentBlob contentBlob(byte[] contentBlob) {
        this.setContentBlob(contentBlob);
        return this;
    }

    public void setContentBlob(byte[] contentBlob) {
        this.contentBlob = contentBlob;
    }

    public String getContentBlobContentType() {
        return this.contentBlobContentType;
    }

    public ContentBlob contentBlobContentType(String contentBlobContentType) {
        this.contentBlobContentType = contentBlobContentType;
        return this;
    }

    public void setContentBlobContentType(String contentBlobContentType) {
        this.contentBlobContentType = contentBlobContentType;
    }

    public Content getContent() {
        return this.content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public ContentBlob content(Content content) {
        this.setContent(content);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ContentBlob)) {
            return false;
        }
        return getId() != null && getId().equals(((ContentBlob) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ContentBlob{" +
            "id=" + getId() +
            ", contentBlob='" + getContentBlob() + "'" +
            ", contentBlobContentType='" + getContentBlobContentType() + "'" +
            "}";
    }
}
