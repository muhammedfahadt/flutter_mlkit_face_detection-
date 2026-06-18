package com.divisosoft.trafficpatrol.service.mapper;

import com.divisosoft.trafficpatrol.domain.AppUser;
import com.divisosoft.trafficpatrol.domain.User;
import com.divisosoft.trafficpatrol.service.dto.AppUserDTO;
import com.divisosoft.trafficpatrol.service.dto.UserDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link AppUser} and its DTO {@link AppUserDTO}.
 */
@Mapper(componentModel = "spring")
public interface AppUserMapper extends EntityMapper<AppUserDTO, AppUser> {
    @Mapping(target = "user", source = "user", qualifiedByName = "userId")
    AppUserDTO toDto(AppUser s);

    @Named("userId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    UserDTO toDtoUserId(User user);
}
