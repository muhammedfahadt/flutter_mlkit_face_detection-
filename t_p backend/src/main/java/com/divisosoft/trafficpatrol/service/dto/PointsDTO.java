package com.divisosoft.trafficpatrol.service.dto;

import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.Objects;

/**
 * A DTO for the {@link com.divisosoft.trafficpatrol.domain.Points} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class PointsDTO implements Serializable {

    private Long id;

    private Long pointsEarned;

    private ZonedDateTime uploadDateTime;

    private AppUserDTO appUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(Long pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public ZonedDateTime getUploadDateTime() {
        return uploadDateTime;
    }

    public void setUploadDateTime(ZonedDateTime uploadDateTime) {
        this.uploadDateTime = uploadDateTime;
    }

    public AppUserDTO getAppUser() {
        return appUser;
    }

    public void setAppUser(AppUserDTO appUser) {
        this.appUser = appUser;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof PointsDTO)) {
            return false;
        }

        PointsDTO pointsDTO = (PointsDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, pointsDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "PointsDTO{" +
            "id=" + getId() +
            ", pointsEarned=" + getPointsEarned() +
            ", uploadDateTime='" + getUploadDateTime() + "'" +
            ", appUser=" + getAppUser() +
            "}";
    }
}
