<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Follows FHIR-Converter DataType/CWECodeableConcept
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    
    <xsl:template name="CWECodeableConcept">
        <xsl:param name="curr"/>
        <xsl:param name="mapping"/>
        <xsl:if test="$mapping">
            <array key="coding">
                <map>
                    <string key="code"><xsl:call-template name="codeInfo">
                            <xsl:with-param name="systemParam" select="$mapping"/>
                            <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                            <xsl:with-param name="whichParam" select="'code'"/>
                        </xsl:call-template></string>
                    <string key="display"><xsl:call-template name="codeInfo">
                            <xsl:with-param name="systemParam" select="$mapping"/>
                            <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                            <xsl:with-param name="whichParam" select="'display'"/>
                        </xsl:call-template></string>
                    <xsl:if test="$curr/hl7:CWE.3">
                        <!-- replace ' ' with '-', replace link with real link,
                             FHIR-Converter has this coded as the default behavior, 
                             but outputs the second if statement below... not sure why 
                             we wouldn't just use the system code/second if statement -->
                        <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.3"/></string>
                    </xsl:if>
                    <xsl:if test="not($curr/hl7:CWE.3)">
                        <string key="system"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                                <xsl:with-param name="whichParam" select="'system'"/>
                            </xsl:call-template></string>
                    </xsl:if>
                    <xsl:if test="$curr/hl7:CWE.7">
                        <string key="version"><xsl:value-of select="$curr/hl7:CWE.7"/></string>
                    </xsl:if>
                    <!-- Removing this - we don't support version in CodeSystem,
                         should be default over above condition
                         <xsl:if test="not($curr/hl7:CWE.7)">
                         <string keFy="version"><xsl:call-template name="codeInfo">
                         <xsl:with-param name="systemParam" select="$mapping"/>
                         <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                         <xsl:with-param name="whichParam" select="'version'"/>
                         </xsl:call-template></string>
                         </xsl:if> -->
                 </map>
                <!-- note for Patient/Language this check (and all other similar ones in this file
                     should really only be for CWE.4 but haven't seen enough use cases to determine otherwise -->
                <xsl:if test="$curr/hl7:CWE.4 or $curr/hl7:CWE.5 or $curr/hl7:CWE.6 or $curr/hl7:CWE.8">
                    <map>
                        <xsl:if test="$curr/hl7:CWE.4">
                            <string key="code"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                    <xsl:with-param name="whichParam" select="'code'"/>
                                </xsl:call-template></string>
                            <xsl:variable name="cwe4display"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                    <xsl:with-param name="whichParam" select="'display'"/>
                                </xsl:call-template></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="$cwe4display=$curr/hl7:CWE.4 and $curr/hl7:CWE.5">
                                    <string key="display"><xsl:value-of select="$curr/hl7:CWE.5"/></string>
                                </xsl:when>
                                <xsl:otherwise>
                                    <string key="display"><xsl:value-of select="$cwe4display"/></string>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$curr/hl7:CWE.6">
                            <!-- replace ' ' with '-', replace link with real link,
                                 FHIR-Converter has this coded as the default behavior, 
                                 but outputs the second if statement below... not sure why 
                                 we wouldn't just use the system code/second if statement -->
                            <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.3"/></string>
                        </xsl:if>
                        <xsl:if test="not($curr/hl7:CWE.6) and $curr/hl7:CWE.4">
                            <string key="system"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                    <xsl:with-param name="whichParam" select="'system'"/>
                                </xsl:call-template></string>
                        </xsl:if>
                        <xsl:if test="$curr/hl7:CWE.8">
                            <string key="version"><xsl:value-of select="$curr/hl7:CWE.8"/></string>
                        </xsl:if>
                        <!-- Removing this - we don't support version in CodeSystem,
                             should be default over above condition
                             <xsl:if test="not($curr/hl7:CWE.8)">
                             <string keFy="version"><xsl:call-template name="codeInfo">
                             <xsl:with-param name="systemParam" select="$mapping"/>
                             <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                             <xsl:with-param name="whichParam" select="'version'"/>
                             </xsl:call-template></string>
                             </xsl:if> -->
                     </map>
                </xsl:if>
                <xsl:if test="$curr/hl7:CWE.10 or $curr/hl7:CWE.11 or $curr/hl7:CWE.12 or $curr/hl7:CWE.13">
                    <map>
                        <xsl:if test="$curr/hl7:CWE.10">
                            <string key="code"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                                    <xsl:with-param name="whichParam" select="'code'"/>
                                </xsl:call-template></string>
                            <xsl:variable name="cwe4display"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                                    <xsl:with-param name="whichParam" select="'display'"/>
                                </xsl:call-template></xsl:variable>
                            <xsl:choose>
                                <xsl:when test="$cwe4display=$curr/hl7:CWE.10 and $curr/hl7:CWE.11">
                                    <string key="display"><xsl:value-of select="$curr/hl7:CWE.11"/></string>
                                </xsl:when>
                                <xsl:otherwise>
                                    <string key="display"><xsl:value-of select="$cwe4display"/></string>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$curr/hl7:CWE.12">
                            <!-- replace ' ' with '-', replace link with real link,
                                 FHIR-Converter has this coded as the default behavior, 
                                 but outputs the second if statement below... not sure why 
                                 we wouldn't just use the system code/second if statement -->
                            <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.3"/></string>
                        </xsl:if>
                        <xsl:if test="not($curr/hl7:CWE.12) and $curr/hl7:CWE.10">
                            <string key="system"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="$mapping"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                    <xsl:with-param name="whichParam" select="'system'"/>
                                </xsl:call-template></string>
                        </xsl:if>
                        <xsl:if test="$curr/hl7:CWE.13">
                            <string key="version"><xsl:value-of select="$curr/hl7:CWE.13"/></string>
                        </xsl:if>
                        <!-- Removing this - we don't support version in CodeSystem,
                             should be default over above condition
                             <xsl:if test="not($curr/hl7:CWE.13)">
                             <string keFy="version"><xsl:call-template name="codeInfo">
                             <xsl:with-param name="systemParam" select="$mapping"/>
                             <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                             <xsl:with-param name="whichParam" select="'version'"/>
                             </xsl:call-template></string>
                             </xsl:if> -->
                     </map>
                </xsl:if>
            </array>
        </xsl:if>
        <xsl:if test="not($mapping)">
            <!-- this should be created but is not necessary for the Patient
                 resource so will make not and leave it for now to save time -->
         </xsl:if>
    </xsl:template>
</xsl:stylesheet>