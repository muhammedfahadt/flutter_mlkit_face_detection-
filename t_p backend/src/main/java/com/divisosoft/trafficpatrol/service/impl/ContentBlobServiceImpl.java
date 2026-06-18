package com.divisosoft.trafficpatrol.service.impl;

import com.divisosoft.trafficpatrol.domain.ContentBlob;
import com.divisosoft.trafficpatrol.repository.ContentBlobRepository;
import com.divisosoft.trafficpatrol.service.ContentBlobService;
import com.divisosoft.trafficpatrol.service.dto.ContentBlobDTO;
import com.divisosoft.trafficpatrol.service.mapper.ContentBlobMapper;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.divisosoft.trafficpatrol.domain.ContentBlob}.
 */
@Service
@Transactional
public class ContentBlobServiceImpl implements ContentBlobService {

    private final Logger log = LoggerFactory.getLogger(ContentBlobServiceImpl.class);

    private final ContentBlobRepository contentBlobRepository;

    private final ContentBlobMapper contentBlobMapper;

    public ContentBlobServiceImpl(ContentBlobRepository contentBlobRepository, ContentBlobMapper contentBlobMapper) {
        this.contentBlobRepository = contentBlobRepository;
        this.contentBlobMapper = contentBlobMapper;
    }

    @Override
    public ContentBlobDTO save(ContentBlobDTO contentBlobDTO) {
        log.debug("Request to save ContentBlob : {}", contentBlobDTO);
        ContentBlob contentBlob = contentBlobMapper.toEntity(contentBlobDTO);
        contentBlob = contentBlobRepository.save(contentBlob);
        return contentBlobMapper.toDto(contentBlob);
    }

    @Override
    public ContentBlobDTO update(ContentBlobDTO contentBlobDTO) {
        log.debug("Request to update ContentBlob : {}", contentBlobDTO);
        ContentBlob contentBlob = contentBlobMapper.toEntity(contentBlobDTO);
        contentBlob = contentBlobRepository.save(contentBlob);
        return contentBlobMapper.toDto(contentBlob);
    }

    @Override
    public Optional<ContentBlobDTO> partialUpdate(ContentBlobDTO contentBlobDTO) {
        log.debug("Request to partially update ContentBlob : {}", contentBlobDTO);

        return contentBlobRepository
            .findById(contentBlobDTO.getId())
            .map(existingContentBlob -> {
                contentBlobMapper.partialUpdate(existingContentBlob, contentBlobDTO);

                return existingContentBlob;
            })
            .map(contentBlobRepository::save)
            .map(contentBlobMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ContentBlobDTO> findAll() {
        log.debug("Request to get all ContentBlobs");
        return contentBlobRepository.findAll().stream().map(contentBlobMapper::toDto).collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ContentBlobDTO> findOne(Long id) {
        log.debug("Request to get ContentBlob : {}", id);
        return contentBlobRepository.findById(id).map(contentBlobMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        log.debug("Request to delete ContentBlob : {}", id);
        contentBlobRepository.deleteById(id);
    }
}
