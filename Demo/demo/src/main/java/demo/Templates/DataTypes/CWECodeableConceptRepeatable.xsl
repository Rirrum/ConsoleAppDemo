<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         DataType corresponding to Fhir-Converter CWECodeableConceptRepeatable
         if mapping/else combined into one if statement each. Left out some
         logic that didn't apply to given system codes, might need to be added
         at a later date.
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    
    <xsl:template name="CWECodeableConceptRepeatable">
        <xsl:param name="curr"/>
        <xsl:param name="mapping"/>
        <xsl:param name="systemHardCodedUrl"/>
        <xsl:if test="$mapping">
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
                    <!-- add replace ' ' with '-' -->
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
                <!-- Removing this section as codes provided don't include "version" key/value pair
                     <xsl:if test="not($curr/hl7:CWE.7)">
                     <string key="version"><xsl:call-template name="codeInfo">
                     <xsl:with-param name="systemParam" select="$mapping"/>
                     <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                     <xsl:with-param name="whichParam" select="'version'"/>
                     </xsl:call-template></string>
                     </xsl:if> -->
             </map>
            <!-- if none of the key/value pairs exist, don't create the map -->
            <xsl:if test="$curr/hl7:CWE.4 or $curr/hl7:CWE.6 or $curr/hl7:CWE.8">
                <map>
                    <xsl:if test="$curr/hl7:CWE.4">
                        <string key="code"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                <xsl:with-param name="whichParam" select="'code'"/>
                            </xsl:call-template></string>
                        <string key="display"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                                <xsl:with-param name="whichParam" select="'display'"/>
                            </xsl:call-template></string>
                    </xsl:if>
                    <xsl:if test="$curr/hl7:CWE.6">
                        <!-- add replace ' ' with '-' -->
                        <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.6"/></string>
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
                    <!-- Removing this section as codes provided don't include "version" key/value pair
                         <xsl:if test="not($curr/hl7:CWE.8)">
                         <string key="version"><xsl:call-template name="codeInfo">
                         <xsl:with-param name="systemParam" select="$mapping"/>
                         <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                         <xsl:with-param name="whichParam" select="'version'"/>
                         </xsl:call-template></string>
                         </xsl:if> -->
                 </map>
            </xsl:if>
            <!-- if none of the key/value pairs exist, don't create the map -->
            <xsl:if test="$curr/hl7:CWE.10 or $curr/hl7:CWE.12 or $curr/hl7:CWE.13">
                <map>
                    <xsl:if test="$curr/hl7:CWE.10">
                        <string key="code"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                                <xsl:with-param name="whichParam" select="'code'"/>
                            </xsl:call-template></string>
                        <string key="display"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                                <xsl:with-param name="whichParam" select="'display'"/>
                            </xsl:call-template></string>
                    </xsl:if>
                    <xsl:if test="$curr/hl7:CWE.12">
                        <!-- add replace ' ' with '-' -->
                        <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.12"/></string>
                    </xsl:if>
                    <xsl:if test="not($curr/hl7:CWE.12) and $curr/hl7:CWE.10">
                        <string key="system"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="$mapping"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                                <xsl:with-param name="whichParam" select="'system'"/>
                            </xsl:call-template></string>
                    </xsl:if>
                    <xsl:if test="$curr/hl7:CWE.13">
                        <string key="version"><xsl:value-of select="$curr/hl7:CWE.13"/></string>
                    </xsl:if>
                    <!-- Removing this section as codes provided don't include "version" key/value pair
                         <xsl:if test="not($curr/hl7:CWE.13)">
                         <string key="version"><xsl:call-template name="codeInfo">
                         <xsl:with-param name="systemParam" select="$mapping"/>
                         <xsl:with-param name="codeParam" select="$curr/hl7:CWE.10"/>
                         <xsl:with-param name="whichParam" select="'version'"/>
                         </xsl:call-template></string>
                         </xsl:if> -->
                 </map>
            </xsl:if>
        </xsl:if>
        <!-- may have to add more conditionals to check if node exists before creating
             each key/value pair to avoid creating blank pairs -->
        <xsl:if test="not($mapping)">
            <map>
                <string key="code"><xsl:value-of select="$curr/hl7:CWE.1"/></string>
                <string key="display"><xsl:value-of select="$curr/hl7:CWE.2"/></string>
                <xsl:choose>
                    <xsl:when test="$curr/hl7:CWE.3 and $systemHardCodedUrl">
                        <string key="system"><xsl:value-of select="$systemHardCodedUrl"/></string>
                    </xsl:when>
                    <xsl:when test="$curr/hl7:CWE.3">
                        <!-- add replace ' ' with '-' -->
                        <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.3"/></string>
                    </xsl:when>
                    <xsl:otherwise>
                        <string key="system"><xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="'CodeSystem/CodeSystemUrl'"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CWE.3"/>
                                <xsl:with-param name="whichParam" select="'system'"/>
                            </xsl:call-template></string>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$curr/hl7:CWE.7">
                    <string key="version"><xsl:value-of select="$curr/hl7:CWE.7"/></string>
                </xsl:if>
            </map>
            <!-- if none of the key/value pairs exist, don't create the map -->
            <xsl:if test="$curr/hl7:CWE.4 or $curr/hl7:CWE.5 or $curr/hl7:CWE.6 or $curr/hl7:CWE.8">
                <map>
                    <string key="code"><xsl:value-of select="$curr/hl7:CWE.4"/></string>
                    <string key="display"><xsl:value-of select="$curr/hl7:CWE.5"/></string>
                    <xsl:choose>
                        <xsl:when test="$curr/hl7:CWE.6 and $systemHardCodedUrl">
                            <string key="system"><xsl:value-of select="$systemHardCodedUrl"/></string>
                        </xsl:when>
                        <xsl:when test="$curr/hl7:CWE.6">
                            <!-- add replace ' ' with '-' -->
                            <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.6"/></string>
                        </xsl:when>
                        <xsl:otherwise>
                            <string key="system"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="'CodeSystem/CodeSystemUrl'"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.6"/>
                                    <xsl:with-param name="whichParam" select="'system'"/>
                                </xsl:call-template></string>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="$curr/hl7:CWE.8">
                        <string key="version"><xsl:value-of select="$curr/hl7:CWE.8"/></string>
                    </xsl:if>
                </map>
            </xsl:if>
            <!-- if none of the key/value pairs exist, don't create the map -->
            <xsl:if test="$curr/hl7:CWE.10 or $curr/hl7:CWE.11 or $curr/hl7:CWE.12 or $curr/hl7:CWE.13">
                <map>
                    <string key="code"><xsl:value-of select="$curr/hl7:CWE.10"/></string>
                    <string key="display"><xsl:value-of select="$curr/hl7:CWE.11"/></string>
                    <xsl:choose>
                        <xsl:when test="$curr/hl7:CWE.12 and $systemHardCodedUrl">
                            <string key="system"><xsl:value-of select="$systemHardCodedUrl"/></string>
                        </xsl:when>
                        <xsl:when test="$curr/hl7:CWE.12">
                            <!-- add replace ' ' with '-' -->
                            <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/<xsl:value-of select="$curr/hl7:CWE.12"/></string>
                        </xsl:when>
                        <xsl:otherwise>
                            <string key="system"><xsl:call-template name="codeInfo">
                                    <xsl:with-param name="systemParam" select="'CodeSystem/CodeSystemUrl'"/>
                                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.12"/>
                                    <xsl:with-param name="whichParam" select="'system'"/>
                                </xsl:call-template></string>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="$curr/hl7:CWE.13">
                        <string key="version"><xsl:value-of select="$curr/hl7:CWE.13"/></string>
                    </xsl:if>
                </map>
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>