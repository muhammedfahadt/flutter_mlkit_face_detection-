package com.divisosoft.trafficpatrol.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A AppUser.
 */
@Entity
@Table(name = "app_user")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class AppUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Pattern(regexp = "^[0-9]{10}$")
    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "address")
    private String address;

    @Column(name = "pin_code")
    private Long pinCode;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(unique = true)
    private User user;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "appUser")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "contentBlobs", "violations", "appUser" }, allowSetters = true)
    private Set<Content> contents = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "appUser")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "violation", "appUser" }, allowSetters = true)
    private Set<Points> points = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "appUser")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "points", "appUser", "content" }, allowSetters = true)
    private Set<Violation> violations = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public AppUser id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public AppUser phoneNumber(String phoneNumber) {
        this.setPhoneNumber(phoneNumber);
        return this;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return this.address;
    }

    public AppUser address(String address) {
        this.setAddress(address);
        return this;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getPinCode() {
        return this.pinCode;
    }

    public AppUser pinCode(Long pinCode) {
        this.setPinCode(pinCode);
        return this;
    }

    public void setPinCode(Long pinCode) {
        this.pinCode = pinCode;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public AppUser user(User user) {
        this.setUser(user);
        return this;
    }

    public Set<Content> getContents() {
        return this.contents;
    }

    public void setContents(Set<Content> contents) {
        if (this.contents != null) {
            this.contents.forEach(i -> i.setAppUser(null));
        }
        if (contents != null) {
            contents.forEach(i -> i.setAppUser(this));
        }
        this.contents = contents;
    }

    public AppUser contents(Set<Content> contents) {
        this.setContents(contents);
        return this;
    }

    public AppUser addContents(Content content) {
        this.contents.add(content);
        content.setAppUser(this);
        return this;
    }

    public AppUser removeContents(Content content) {
        this.contents.remove(content);
        content.setAppUser(null);
        return this;
    }

    public Set<Points> getPoints() {
        return this.points;
    }

    public void setPoints(Set<Points> points) {
        if (this.points != null) {
            this.points.forEach(i -> i.setAppUser(null));
        }
        if (points != null) {
            points.forEach(i -> i.setAppUser(this));
        }
        this.points = points;
    }

    public AppUser points(Set<Points> points) {
        this.setPoints(points);
        return this;
    }

    public AppUser addPoints(Points points) {
        this.points.add(points);
        points.setAppUser(this);
        return this;
    }

    public AppUser removePoints(Points points) {
        this.points.remove(points);
        points.setAppUser(null);
        return this;
    }

    public Set<Violation> getViolations() {
        return this.violations;
    }

    public void setViolations(Set<Violation> violations) {
        if (this.violations != null) {
            this.violations.forEach(i -> i.setAppUser(null));
        }
        if (violations != null) {
            violations.forEach(i -> i.setAppUser(this));
        }
        this.violations = violations;
    }

    public AppUser violations(Set<Violation> violations) {
        this.setViolations(violations);
        return this;
    }

    public AppUser addViolations(Violation violation) {
        this.violations.add(violation);
        violation.setAppUser(this);
        return this;
    }

    public AppUser removeViolations(Violation violation) {
        this.violations.remove(violation);
        violation.setAppUser(null);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof AppUser)) {
            return false;
        }
        return getId() != null && getId().equals(((AppUser) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "AppUser{" +
            "id=" + getId() +
            ", phoneNumber='" + getPhoneNumber() + "'" +
            ", address='" + getAddress() + "'" +
            ", pinCode=" + getPinCode() +
            "}";
    }
}
