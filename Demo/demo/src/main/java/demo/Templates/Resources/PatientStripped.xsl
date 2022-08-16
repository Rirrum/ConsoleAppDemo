<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         FHIR Patient Resource as a re-usable mapping template
         This stripped template contains the minimum mappings
         listed in the FHIR specification, see:
         (https://www.hl7.org/fhir/patient-mappings.html)
         
         Note: also contains request section for FHIR Dataverse
         
    -->
    
    <xsl:import href="../DataTypes/CX.xsl"/>
    <xsl:import href="../Functions/GetUUID.xsl"/>
    <xsl:import href="../DataTypes/DLN.xsl"/>
    <xsl:import href="../DataTypes/CWECodeableConceptRepeatable.xsl"/>
    <xsl:import href="../DataTypes/DRPeriod.xsl"/>
    <xsl:import href="../DataTypes/XPN.xsl"/>
    <xsl:import href="../DataTypes/CWECode.xsl"/>
    <xsl:import href="../DataTypes/XAD.xsl"/>
    <xsl:import href="../DataTypes/XTN.xsl"/>
    <xsl:import href="../DataTypes/CWECodeableConcept.xsl"/>
    
    <xsl:template name="Patient">
        <!-- for deceasedBoolean, pass any value to pdaSeg
             if there is a PDA segment and Patient resource is
             being included from GT1 (may not be necessary at all) -->
        <xsl:param name="pdaSeg"/>
        <xsl:param name="rootTemplate"/>
        <!-- insurance param must be passed from message template if 
             the message has insurance segments nested. Leaving it blank will 
             not include the maps where it is called - this doesn't lose any data
             Format: 'hl7:ADT_A0x.INSURANCE' -->
        <xsl:param name="insurance"/>
        <xsl:variable name="id"><xsl:call-template name="GetUUID">
                <xsl:with-param name="curr" select="./hl7:PID"/>
            </xsl:call-template></xsl:variable>
        <map>
            <!-- generate resource metadata -->
            <string key="fullUrl">urn:uuid:<xsl:value-of select="$id"/></string>
            <map key="resource">
                <string key="resourceType">Patient</string>
                <string key="id"><xsl:call-template name="GetUUID">
                        <xsl:with-param name="curr" select="./hl7:PID"/>
                    </xsl:call-template></string>
                
                <!-- This section populates identifiers, some are hardcoded and 
                     some rely on DataTypes templates to generate values -->
                <array key="identifier">
                    
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.3">
                        <xsl:if test="./hl7:CX.5"> 
                            <xsl:call-template name="CX">
                                <!-- pass current node in for-each loop -->
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:for-each>
                    
                </array>
                
                <!-- links (needs to be tested) -->
                <xsl:if test="./hl7:MRG/hl7:MRG.1">
                    <array key="link">
                        <map>
                            <map key="other">
                                <map key="identifier">
                                    <xsl:call-template name="CX">
                                        <!-- MRG.1 is repeatable, this should only call the first repetition -->
                                        <xsl:with-param name="curr" select="./hl7:MRG/hl7:MRG.1"/>
                                    </xsl:call-template>
                                </map>
                            </map>
                        </map>
                    </array>
                </xsl:if>
                
                <!-- handle patient name -->
                <array key="name">
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.5">
                        <map>
                            <xsl:call-template name="XPN">
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                        </map>
                    </xsl:for-each>
                    
                    <xsl:if test="./hl7:PID/hl7:PID.9">
                        <map>
                            <xsl:call-template name="XPN">
                                <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.9"/>
                            </xsl:call-template>
                        </map>
                    </xsl:if>
                    
                </array>
                
                <!-- handle birth date - key birthDate is truncated to yyyy-mm-dd 
                     but full date/time is preserved if truncation occurs-->
                <xsl:if test="./hl7:PID/hl7:PID.7">
                    <xsl:variable name="birth-date">
                        <xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="./hl7:PID/hl7:PID.7"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <string key="birthDate"><xsl:value-of select="substring($birth-date,0,11)"/></string>
                    <xsl:if test="string-length($birth-date) > 10">
                        <map key="_birthDate">
                            <array key="extension"> 
                                <map>
                                    <string key="url">http://hl7.org/fhir/StructureDefinition/patient-birthTime</string>
                                    <string key="valueDateTime"><xsl:value-of select="$birth-date"/></string>
                                </map>
                            </array>
                        </map>
                    </xsl:if>
                </xsl:if>
                
                <!-- gender -->
                <xsl:if test="./hl7:PID/hl7:PID.8">
                    <string key="gender"><xsl:call-template name="CWECode">
                            <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.8"/>
                            <xsl:with-param name="mapping" select="'CodeSystem/Gender'"/>
                        </xsl:call-template></string>
                </xsl:if>
                
                <!-- address -->
                <array key="address">
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.11">
                        <map>
                            <xsl:call-template name="XAD">
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                        </map>
                        <!-- FHIR Converter has logic to add k/v pair "district"/PID.12
                             if there is only one repetition of PID.11 but this shouldn't be
                             necessary as district is handled in XAD -->
                     </xsl:for-each>
                </array>
                
                <!-- telecom -->
                <array key="telecom">
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.13">
                        <map>
                            <xsl:call-template name="XTN">
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                            <xsl:if test="./hl7:XTN.2='' or not(./hl7:XTN.2)">
                                <string key="use">home</string>
                            </xsl:if>
                        </map>
                    </xsl:for-each>
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.14">
                        <map>
                            <xsl:call-template name="XTN">
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                            <xsl:if test="./hl7:XTN.2='' or not(./hl7:XTN.2)">
                                <string key="use">work</string>
                            </xsl:if>
                        </map>
                    </xsl:for-each>
                    <!-- repeatable field -->
                    <xsl:for-each select="./hl7:PID/hl7:PID.40">
                        <map>
                            <xsl:call-template name="XTN">
                                <xsl:with-param name="curr" select="."/>
                            </xsl:call-template>
                        </map>
                    </xsl:for-each>
                </array>
                
                <!-- deceased, this will probably rarely be called but follows
                     FHIR-Converter Logic -->
                <xsl:if test="not(./hl7:PID/hl7:PID.29) and not(./hl7:PID/hl7:PID.30)
                    and not(./hl7:GT1/hl7:GT1.24) and not(./hl7:GT1/hl7:GT1.25) and $pdaSeg">
                    <string key="deceasedBoolean">true</string>
                </xsl:if>
                
                <!-- communication -->
                <array key="communication">
                    <xsl:choose>
                        <xsl:when test="./hl7:PID/hl7:PID.15">
                            <map>
                                <map key="language">
                                    <xsl:call-template name="CWECodeableConcept">
                                        <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.15"/>
                                        <xsl:with-param name="mapping" select="'CodeSystem/Language'"/>
                                    </xsl:call-template>
                                </map>
                                <string key="preferred">true</string>
                            </map>
                        </xsl:when>
                    </xsl:choose>
                </array>
                
                <!-- marital status -->
                <xsl:if test="./hl7:PID/hl7:PID.16 or ./hl7:GT1/hl7:GT1.30">
                    <xsl:if test="./hl7:PID/hl7:PID.16">
                        <map key="maritalStatus">
                            <xsl:call-template name="CWECodeableConcept">
                                <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.16"/>
                                <xsl:with-param name="mapping" select="'CodeSystem/MaritalStatus'"/>
                            </xsl:call-template>
                        </map>
                    </xsl:if>
                </xsl:if>
                
                <!-- multiple births (twins/birth order?) not sure what this is -->
                <xsl:if test="./hl7:PID/hl7:PID.25">
                    <string key="multipleBirthInteger"><xsl:value-of select="./hl7:PID/hl7:PID.25"/></string>
                </xsl:if>
                <xsl:if test="not(./hl7:PID/hl7:PID.25) and ./hl7:PID/hl7:PID.24">
                    <string key="multipleBirthBoolean"><xsl:value-of select="./hl7:PID/hl7:PID.24"/></string>
                </xsl:if>
                
                <!-- deceased -->
                <xsl:if test="./hl7:PID/hl7:PID.29">
                    <string key="deceasedDateTime">
                        <xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="./hl7:PID/hl7:PID.29"/>
                        </xsl:call-template></string>
                </xsl:if>
                <xsl:if test="not(./hl7:PID/hl7:PID.29)">
                    <xsl:if test="./hl7:PID/hl7:PID.30">
                        <string key="deceasedBoolean"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="'CodeSystem/Yes_No'"/>
                                <xsl:with-param name="codeParam" select="./hl7:PID/hl7:PID.30"/>
                                <xsl:with-param name="whichParam" select="'code'"/>
                            </xsl:call-template></string>
                    </xsl:if>
                </xsl:if>
                
                <!-- active = whether the record is active or not
                     there is no recommended mapping from Hl7v2 so we
                     follow the FHIR-Converter that uses Marital Status -->
                <xsl:if test="./hl7:PID/hl7:PID.16/hl7:CWE.1">
                    <string key="active"><xsl:call-template name="codeInfo">
                            <xsl:with-param name="systemParam" select="'CodeSystem/RegistryStatus'"/>
                            <xsl:with-param name="codeParam" select="./hl7:PID/hl7:PID.16/hl7:CWE.1"/>
                            <xsl:with-param name="whichParam" select="'code'"/>
                        </xsl:call-template></string>
                </xsl:if>
                
                <!-- general practitioner -->
                <array key="generalPractitioner">
                    <xsl:if test="./hl7:PD1/hl7:PD1.3">
                        <map>
                            <string key="reference">Organization/<xsl:call-template name="GetUUID">
                                    <xsl:with-param name="curr" select="./hl7:PD1/hl7:PD1.3"/>
                                </xsl:call-template></string>
                        </map>
                    </xsl:if>
                    <xsl:if test="./hl7:PD1/hl7:PD1.4">
                        <map>
                            <string key="reference">Organization/<xsl:call-template name="GetUUID">
                                    <xsl:with-param name="curr" select="./hl7:PD1/hl7:PD1.4"/>
                                </xsl:call-template></string>
                        </map>
                    </xsl:if>
                </array>
                
                <!-- contacts - FHIR-Converter has confusing logic that doesn't
                     translate well, reconstructed this section based on desired output
                     and consulting FHIR Patient resource schema. FHIR-Converter also 
                     only grabs the first NK1 segment, ignores repeats - don't know why -->
                <array key="contact">
                    <!-- first handle next of kin contacts -->
                    <xsl:for-each select="./hl7:NK1">
                        <map>
                            <map key="name">
                                <xsl:call-template name="XPN">
                                    <xsl:with-param name="curr" select="./hl7:NK1.2"/>
                                </xsl:call-template>
                            </map>
                            <map key="address">
                                <xsl:call-template name="XAD">
                                    <xsl:with-param name="curr" select="./hl7:NK1.4"/>
                                </xsl:call-template>
                            </map>
                            <array key="telecom">
                                <xsl:for-each select="./hl7:NK1.5">
                                    <map>
                                        <xsl:call-template name="XTN">
                                            <xsl:with-param name="curr" select="."/>
                                        </xsl:call-template>
                                        <xsl:if test="./hl7:XTN.2='' or not(./hl7:XTN.2)">
                                            <string key="use">home</string>
                                        </xsl:if>
                                    </map>
                                </xsl:for-each>
                                <xsl:for-each select="./hl7:NK1.6">
                                    <map>
                                        <xsl:call-template name="XTN">
                                            <xsl:with-param name="curr" select="."/>
                                        </xsl:call-template>
                                        <xsl:if test="./hl7:XTN.2='' or not(./hl7:XTN.2)">
                                            <string key="use">work</string>
                                        </xsl:if>
                                    </map>
                                </xsl:for-each>
                                <xsl:if test="./hl7:NK1.40">
                                    <map>
                                        <xsl:call-template name="XTN">
                                            <xsl:with-param name="curr" select="./hl7:NK1.40"/>
                                        </xsl:call-template>
                                    </map>
                                </xsl:if>
                                <xsl:if test="./hl7:NK1.41">
                                    <map>
                                        <xsl:call-template name="XTN">
                                            <xsl:with-param name="curr" select="./hl7:NK1.41"/>
                                        </xsl:call-template>
                                    </map>
                                </xsl:if>
                            </array>
                            <xsl:if test="./hl7:NK1.7">
                                <array key="relationship">
                                    <map>
                                        <xsl:call-template name="CWECodeableConcept">
                                            <xsl:with-param name="mapping" select="'CodeSystem/ContactRole'"/>
                                            <xsl:with-param name="curr" select="./hl7:NK1.7"/>
                                        </xsl:call-template>
                                    </map>
                                </array>
                            </xsl:if>
                            <xsl:if test="./hl7:NK1.8 or ./hl7:NK1.9">
                                <map key="period">
                                    <xsl:if test="./hl7:NK1.8">
                                        <string key="start"><xsl:call-template name="DateTime">
                                                <xsl:with-param name="date" select="./hl7:NK1.8"/>
                                            </xsl:call-template></string>
                                    </xsl:if>
                                    <xsl:if test="./hl7:NK1.9">
                                        <string key="end"><xsl:call-template name="DateTime">
                                                <xsl:with-param name="date" select="./hl7:NK1.9"/>
                                            </xsl:call-template></string>
                                    </xsl:if>
                                </map>
                            </xsl:if>
                            <xsl:if test="./hl7:NK1.15/hl7:CWE.1">
                                <string key="gender"><xsl:call-template name="codeInfo">
                                        <xsl:with-param name="systemParam" select="'CodeSystem/Gender'"/>
                                        <xsl:with-param name="codeParam" select="./hl7:NK1.15/hl7:CWE.1"/>
                                        <xsl:with-param name="whichParam" select="'code'"/>
                                    </xsl:call-template> </string>
                            </xsl:if>
                            <xsl:if test="not(./hl7:NK1.15/hl7:CWE.1) and ./hl7:NK1.15/hl7:CWE.4">
                                <string key="gender"><xsl:call-template name="codeInfo">
                                        <xsl:with-param name="systemParam" select="'CodeSystem/Gender'"/>
                                        <xsl:with-param name="codeParam" select="./hl7:NK1.15/hl7:CWE.4"/>
                                        <xsl:with-param name="whichParam" select="'code'"/>
                                    </xsl:call-template> </string>
                            </xsl:if>
                            <xsl:if test="./hl7:NK1.13">
                                <map key="organization">
                                    <string key="reference">Organization/<xsl:call-template name="GetUUID">
                                            <xsl:with-param name="curr" select="./hl7:NK1.13"/>
                                        </xsl:call-template></string>
                                </map>
                            </xsl:if>
                        </map>
                    </xsl:for-each>
                </array>
                
                <!-- managing organization -->
                <map key="managingOrganization">
                    <string key="reference">Organization/<xsl:call-template name="GetUUID">
                            <xsl:with-param name="curr" select="./hl7:NK1/hl7:NK1.13"/>
                        </xsl:call-template></string>
                </map>
                
                <!-- extension - to be built by customers, including a sample
                     from FHIR-Converter (birth place) -->
                <array key="extension">
                    <xsl:if test="./hl7:GT1/hl7:GT1.56">
                        <map>
                            <string key="url">http://hl7.org/fhir/StructureDefinition/patient-birthPlace</string>
                            <map key="valueAddress">
                                <string key="text"><xsl:value-of select="./hl7:GT1/hl7:GT1.56"/></string>
                            </map>
                        </map>
                    </xsl:if>
                </array>
                
                <!-- request -->
                <map key="request">
                    <xsl:if test="$rootTemplate='ADT_A29'">
                        <string key="method">DELETE</string>
                    </xsl:if>
                    <xsl:if test="not($rootTemplate='ADT_A29')">
                        <string key="method">PUT</string>
                    </xsl:if>
                    <string key="url">Patient/<xsl:value-of select="$id"/></string>
                </map>
            </map>
        </map>
    </xsl:template>
</xsl:stylesheet>