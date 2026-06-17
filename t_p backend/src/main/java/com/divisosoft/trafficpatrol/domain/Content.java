package com.divisosoft.trafficpatrol.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Content.
 */
@Entity
@Table(name = "content")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Content implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "content_type")
    private String contentType;

    @Column(name = "upload_date_time")
    private ZonedDateTime uploadDateTime;

    @Column(name = "status")
    private String status;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "content")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "content" }, allowSetters = true)
    private Set<ContentBlob> contentBlobs = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "content")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "points", "appUser", "content" }, allowSetters = true)
    private Set<Violation> violations = new HashSet<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "user", "contents", "points", "violations" }, allowSetters = true)
    private AppUser appUser;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Content id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContentType() {
        return this.contentType;
    }

    public Content contentType(String contentType) {
        this.setContentType(contentType);
        return this;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public ZonedDateTime getUploadDateTime() {
        return this.uploadDateTime;
    }

    public Content uploadDateTime(ZonedDateTime uploadDateTime) {
        this.setUploadDateTime(uploadDateTime);
        return this;
    }

    public void setUploadDateTime(ZonedDateTime uploadDateTime) {
        this.uploadDateTime = uploadDateTime;
    }

    public String getStatus() {
        return this.status;
    }

    public Content status(String status) {
        this.setStatus(status);
        return this;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<ContentBlob> getContentBlobs() {
        return this.contentBlobs;
    }

    public void setContentBlobs(Set<ContentBlob> contentBlobs) {
        if (this.contentBlobs != null) {
            this.contentBlobs.forEach(i -> i.setContent(null));
        }
        if (contentBlobs != null) {
            contentBlobs.forEach(i -> i.setContent(this));
        }
        this.contentBlobs = contentBlobs;
    }

    public Content contentBlobs(Set<ContentBlob> contentBlobs) {
        this.setContentBlobs(contentBlobs);
        return this;
    }

    public Content addContentBlob(ContentBlob contentBlob) {
        this.contentBlobs.add(contentBlob);
        contentBlob.setContent(this);
        return this;
    }

    public Content removeContentBlob(ContentBlob contentBlob) {
        this.contentBlobs.remove(contentBlob);
        contentBlob.setContent(null);
        return this;
    }

    public Set<Violation> getViolations() {
        return this.violations;
    }

    public void setViolations(Set<Violation> violations) {
        if (this.violations != null) {
            this.violations.forEach(i -> i.setContent(null));
        }
        if (violations != null) {
            violations.forEach(i -> i.setContent(this));
        }
        this.violations = violations;
    }

    public Content violations(Set<Violation> violations) {
        this.setViolations(violations);
        return this;
    }

    public Content addViolations(Violation violation) {
        this.violations.add(violation);
        violation.setContent(this);
        return this;
    }

    public Content removeViolations(Violation violation) {
        this.violations.remove(violation);
        violation.setContent(null);
        return this;
    }

    public AppUser getAppUser() {
        return this.appUser;
    }

    public void setAppUser(AppUser appUser) {
        this.appUser = appUser;
    }

    public Content appUser(AppUser appUser) {
        this.setAppUser(appUser);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Content)) {
            return false;
        }
        return getId() != null && getId().equals(((Content) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Content{" +
            "id=" + getId() +
            ", contentType='" + getContentType() + "'" +
            ", uploadDateTime='" + getUploadDateTime() + "'" +
            ", status='" + getStatus() + "'" +
            "}";
    }
}
