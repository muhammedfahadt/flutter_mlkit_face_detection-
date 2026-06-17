package com.divisosoft.trafficpatrol.service.mapper;

import com.divisosoft.trafficpatrol.domain.AppUser;
import com.divisosoft.trafficpatrol.domain.Content;
import com.divisosoft.trafficpatrol.domain.Points;
import com.divisosoft.trafficpatrol.domain.Violation;
import com.divisosoft.trafficpatrol.service.dto.AppUserDTO;
import com.divisosoft.trafficpatrol.service.dto.ContentDTO;
import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
import com.divisosoft.trafficpatrol.service.dto.ViolationDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Violation} and its DTO {@link ViolationDTO}.
 */
@Mapper(componentModel = "spring")
public interface ViolationMapper extends EntityMapper<ViolationDTO, Violation> {
    @Mapping(target = "points", source = "points", qualifiedByName = "pointsId")
    @Mapping(target = "appUser", source = "appUser", qualifiedByName = "appUserId")
    @Mapping(target = "content", source = "content", qualifiedByName = "contentId")
    ViolationDTO toDto(Violation s);

    @Named("pointsId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    PointsDTO toDtoPointsId(Points points);

    @Named("appUserId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    AppUserDTO toDtoAppUserId(AppUser appUser);

    @Named("contentId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ContentDTO toDtoContentId(Content content);
}
