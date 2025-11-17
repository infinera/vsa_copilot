<!-- Agent-local copy of SRD template -->
# System Requirements Document (SRD)
**Project Name**: [Enter Project Name]  
**Version**: [vX.X]  
**Date**: [YYYY-MM-DD]  
**Author**: [Your Name]  

---

## 1. Introduction
- **Purpose**: Describe the goal of the system and its intended users.
- **Scope**: Define boundaries and constraints.
- **References**: Link to PRD, architecture diagrams, and related documents.

---

## 2. System Overview
- **System Context**: High-level description of the system.
- **Architecture Summary**: Include diagrams or links.

---

## 3. Functional Requirements
| Req ID | Description | Priority | Acceptance Criteria |
|--------|-------------|----------|----------------------|
| FR-001 | [Requirement text] | High | [Criteria] |

---

## 4. Non-Functional Requirements
| Req ID | Description | Category (Performance, Security, etc.) |
|--------|-------------|-----------------------------------------|
| NFR-001 | [Requirement text] | Performance |

---

## 5. Interfaces
- **API Specifications**:  
  - Endpoint: `/api/v1/...`  
  - Method: `GET/POST`  
  - Request/Response Format: JSON  

- **CLI Specifications**:  
  - Command: `vsa-agent --generate`  
  - Parameters: `--input <SRD>`  
  - Example: `vsa-agent --generate epic`

---

## 6. Traceability Matrix
| Req ID | Epic/User Story | Test Case ID |
|--------|-----------------|--------------|
| FR-001 | EPIC-01        | TC-001      |

---

## 7. Assumptions and Constraints
- [List assumptions]
- [List constraints]

---

## 8. Glossary
- Define key terms and acronyms.

---

## 9. Appendices
- Additional diagrams, references, or notes.

---

**Generated for GitHub CoPilot VSA Agent Integration**