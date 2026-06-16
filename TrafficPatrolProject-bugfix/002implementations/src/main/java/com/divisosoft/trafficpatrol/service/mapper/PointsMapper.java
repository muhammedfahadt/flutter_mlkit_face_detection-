package com.divisosoft.trafficpatrol.service.mapper;

import com.divisosoft.trafficpatrol.domain.AppUser;
import com.divisosoft.trafficpatrol.domain.Points;
import com.divisosoft.trafficpatrol.service.dto.AppUserDTO;
import com.divisosoft.trafficpatrol.service.dto.PointsDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Points} and its DTO {@link PointsDTO}.
 */
@Mapper(componentModel = "spring")
public interface PointsMapper extends EntityMapper<PointsDTO, Points> {
    @Mapping(target = "appUser", source = "appUser", qualifiedByName = "appUserId")
    PointsDTO toDto(Points s);

    @Named("appUserId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    AppUserDTO toDtoAppUserId(AppUser appUser);
}
