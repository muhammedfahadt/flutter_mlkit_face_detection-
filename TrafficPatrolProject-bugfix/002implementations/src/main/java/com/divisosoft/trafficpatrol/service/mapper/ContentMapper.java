package com.divisosoft.trafficpatrol.service.mapper;

import com.divisosoft.trafficpatrol.domain.AppUser;
import com.divisosoft.trafficpatrol.domain.Content;
import com.divisosoft.trafficpatrol.service.dto.AppUserDTO;
import com.divisosoft.trafficpatrol.service.dto.ContentDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Content} and its DTO {@link ContentDTO}.
 */
@Mapper(componentModel = "spring")
public interface ContentMapper extends EntityMapper<ContentDTO, Content> {
    @Mapping(target = "appUser", source = "appUser", qualifiedByName = "appUserId")
    ContentDTO toDto(Content s);

    @Named("appUserId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    AppUserDTO toDtoAppUserId(AppUser appUser);
}
