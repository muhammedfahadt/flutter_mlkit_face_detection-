package com.divisosoft.trafficpatrol.service.mapper;

import com.divisosoft.trafficpatrol.domain.Content;
import com.divisosoft.trafficpatrol.domain.ContentBlob;
import com.divisosoft.trafficpatrol.service.dto.ContentBlobDTO;
import com.divisosoft.trafficpatrol.service.dto.ContentDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link ContentBlob} and its DTO {@link ContentBlobDTO}.
 */
@Mapper(componentModel = "spring")
public interface ContentBlobMapper extends EntityMapper<ContentBlobDTO, ContentBlob> {
    @Mapping(target = "content", source = "content", qualifiedByName = "contentId")
    ContentBlobDTO toDto(ContentBlob s);

    @Named("contentId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ContentDTO toDtoContentId(Content content);
}
