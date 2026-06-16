package com.divisosoft.trafficpatrol.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Violation.
 */
@Entity
@Table(name = "violation")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Violation implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "violation_type")
    private String violationType;

    @JsonIgnoreProperties(value = { "violation", "appUser" }, allowSetters = true)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(unique = true)
    private Points points;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "user", "contents", "points", "violations" }, allowSetters = true)
    private AppUser appUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "contentBlobs", "violations", "appUser" }, allowSetters = true)
    private Content content;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Violation id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getViolationType() {
        return this.violationType;
    }

    public Violation violationType(String violationType) {
        this.setViolationType(violationType);
        return this;
    }

    public void setViolationType(String violationType) {
        this.violationType = violationType;
    }

    public Points getPoints() {
        return this.points;
    }

    public void setPoints(Points points) {
        this.points = points;
    }

    public Violation points(Points points) {
        this.setPoints(points);
        return this;
    }

    public AppUser getAppUser() {
        return this.appUser;
    }

    public void setAppUser(AppUser appUser) {
        this.appUser = appUser;
    }

    public Violation appUser(AppUser appUser) {
        this.setAppUser(appUser);
        return this;
    }

    public Content getContent() {
        return this.content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public Violation content(Content content) {
        this.setContent(content);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Violation)) {
            return false;
        }
        return getId() != null && getId().equals(((Violation) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Violation{" +
            "id=" + getId() +
            ", violationType='" + getViolationType() + "'" +
            "}";
    }
}
