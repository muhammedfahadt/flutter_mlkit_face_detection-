package com.divisosoft.trafficpatrol.service.dto;

import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.divisosoft.trafficpatrol.domain.Violation} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ViolationDTO implements Serializable {

    private Long id;

    private String violationType;

    private PointsDTO points;

    private AppUserDTO appUser;

    private ContentDTO content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getViolationType() {
        return violationType;
    }

    public void setViolationType(String violationType) {
        this.violationType = violationType;
    }

    public PointsDTO getPoints() {
        return points;
    }

    public void setPoints(PointsDTO points) {
        this.points = points;
    }

    public AppUserDTO getAppUser() {
        return appUser;
    }

    public void setAppUser(AppUserDTO appUser) {
        this.appUser = appUser;
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
        if (!(o instanceof ViolationDTO)) {
            return false;
        }

        ViolationDTO violationDTO = (ViolationDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, violationDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ViolationDTO{" +
            "id=" + getId() +
            ", violationType='" + getViolationType() + "'" +
            ", points=" + getPoints() +
            ", appUser=" + getAppUser() +
            ", content=" + getContent() +
            "}";
    }
}
