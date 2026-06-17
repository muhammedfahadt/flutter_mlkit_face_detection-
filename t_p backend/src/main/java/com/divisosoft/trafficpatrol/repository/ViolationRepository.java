package com.divisosoft.trafficpatrol.repository;

import com.divisosoft.trafficpatrol.domain.Violation;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the Violation entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ViolationRepository extends JpaRepository<Violation, Long> {}
