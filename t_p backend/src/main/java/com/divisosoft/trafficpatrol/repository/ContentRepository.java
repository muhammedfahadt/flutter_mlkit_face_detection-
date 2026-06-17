package com.divisosoft.trafficpatrol.repository;

import com.divisosoft.trafficpatrol.domain.Content;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the Content entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ContentRepository extends JpaRepository<Content, Long> {}
