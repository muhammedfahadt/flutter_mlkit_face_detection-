package com.divisosoft.trafficpatrol.service.dto;

import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.Objects;

/**
 * A DTO for the {@link com.divisosoft.trafficpatrol.domain.Content} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ContentDTO implements Serializable {

    private Long id;

    private String contentType;

    private ZonedDateTime uploadDateTime;

    private String status;

    private AppUserDTO appUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public ZonedDateTime getUploadDateTime() {
        return uploadDateTime;
    }

    public void setUploadDateTime(ZonedDateTime uploadDateTime) {
        this.uploadDateTime = uploadDateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        if (!(o instanceof ContentDTO)) {
            return false;
        }

        ContentDTO contentDTO = (ContentDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, contentDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ContentDTO{" +
            "id=" + getId() +
            ", contentType='" + getContentType() + "'" +
            ", uploadDateTime='" + getUploadDateTime() + "'" +
            ", status='" + getStatus() + "'" +
            ", appUser=" + getAppUser() +
            "}";
    }
}
