package com.divisosoft.trafficpatrol.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import java.time.ZonedDateTime;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Points.
 */
@Entity
@Table(name = "points")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Points implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "points_earned")
    private Long pointsEarned;

    @Column(name = "upload_date_time")
    private ZonedDateTime uploadDateTime;

    @JsonIgnoreProperties(value = { "points", "appUser", "content" }, allowSetters = true)
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "points")
    private Violation violation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "user", "contents", "points", "violations" }, allowSetters = true)
    private AppUser appUser;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Points id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPointsEarned() {
        return this.pointsEarned;
    }

    public Points pointsEarned(Long pointsEarned) {
        this.setPointsEarned(pointsEarned);
        return this;
    }

    public void setPointsEarned(Long pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public ZonedDateTime getUploadDateTime() {
        return this.uploadDateTime;
    }

    public Points uploadDateTime(ZonedDateTime uploadDateTime) {
        this.setUploadDateTime(uploadDateTime);
        return this;
    }

    public void setUploadDateTime(ZonedDateTime uploadDateTime) {
        this.uploadDateTime = uploadDateTime;
    }

    public Violation getViolation() {
        return this.violation;
    }

    public void setViolation(Violation violation) {
        if (this.violation != null) {
            this.violation.setPoints(null);
        }
        if (violation != null) {
            violation.setPoints(this);
        }
        this.violation = violation;
    }

    public Points violation(Violation violation) {
        this.setViolation(violation);
        return this;
    }

    public AppUser getAppUser() {
        return this.appUser;
    }

    public void setAppUser(AppUser appUser) {
        this.appUser = appUser;
    }

    public Points appUser(AppUser appUser) {
        this.setAppUser(appUser);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Points)) {
            return false;
        }
        return getId() != null && getId().equals(((Points) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Points{" +
            "id=" + getId() +
            ", pointsEarned=" + getPointsEarned() +
            ", uploadDateTime='" + getUploadDateTime() + "'" +
            "}";
    }
}
