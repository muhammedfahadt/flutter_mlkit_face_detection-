package com.divisosoft.trafficpatrol.service.impl;

import com.divisosoft.trafficpatrol.domain.Violation;
import com.divisosoft.trafficpatrol.repository.ViolationRepository;
import com.divisosoft.trafficpatrol.service.ViolationService;
import com.divisosoft.trafficpatrol.service.dto.ViolationDTO;
import com.divisosoft.trafficpatrol.service.mapper.ViolationMapper;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.divisosoft.trafficpatrol.domain.Violation}.
 */
@Service
@Transactional
public class ViolationServiceImpl implements ViolationService {

    private final Logger log = LoggerFactory.getLogger(ViolationServiceImpl.class);

    private final ViolationRepository violationRepository;

    private final ViolationMapper violationMapper;

    public ViolationServiceImpl(ViolationRepository violationRepository, ViolationMapper violationMapper) {
        this.violationRepository = violationRepository;
        this.violationMapper = violationMapper;
    }

    @Override
    public ViolationDTO save(ViolationDTO violationDTO) {
        log.debug("Request to save Violation : {}", violationDTO);
        Violation violation = violationMapper.toEntity(violationDTO);
        violation = violationRepository.save(violation);
        return violationMapper.toDto(violation);
    }

    @Override
    public ViolationDTO update(ViolationDTO violationDTO) {
        log.debug("Request to update Violation : {}", violationDTO);
        Violation violation = violationMapper.toEntity(violationDTO);
        violation = violationRepository.save(violation);
        return violationMapper.toDto(violation);
    }

    @Override
    public Optional<ViolationDTO> partialUpdate(ViolationDTO violationDTO) {
        log.debug("Request to partially update Violation : {}", violationDTO);

        return violationRepository
            .findById(violationDTO.getId())
            .map(existingViolation -> {
                violationMapper.partialUpdate(existingViolation, violationDTO);

                return existingViolation;
            })
            .map(violationRepository::save)
            .map(violationMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ViolationDTO> findAll() {
        log.debug("Request to get all Violations");
        return violationRepository.findAll().stream().map(violationMapper::toDto).collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ViolationDTO> findOne(Long id) {
        log.debug("Request to get Violation : {}", id);
        return violationRepository.findById(id).map(violationMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        log.debug("Request to delete Violation : {}", id);
        violationRepository.deleteById(id);
    }
}
