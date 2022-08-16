<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Following XPN template in FHIR Converter to handle names
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/>
    <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="XPN">
        <xsl:param name="curr"/>
        <xsl:variable name="use">
            <xsl:call-template name="codeInfo">
                <xsl:with-param name="systemParam" select="'CodeSystem/NameType'"/>
                <xsl:with-param name="codeParam" select="$curr/hl7:XPN.7"/>
                <xsl:with-param name="whichParam" select="'code'"/>
            </xsl:call-template> 
        </xsl:variable>
        <!-- required so no check -->
        <string key="family"><xsl:value-of select="$curr/hl7:XPN.1/hl7:FN.1"/></string>
        <!-- optional -->
        <xsl:if test="$curr/hl7:XPN.2 or $curr/hl7:XPN.3 or ($use='usual' and $curr/hl7:XPN.15)">     
            <array key="given">
                <xsl:if test="$curr/hl7:XPN.2">
                    <string><xsl:value-of select="$curr/hl7:XPN.2"/></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XPN.3">
                    <string><xsl:value-of select="$curr/hl7:XPN.3"/></string>
                </xsl:if>
                <xsl:if test="$use='usual' and $curr/hl7:XPN.15">
                    <string><xsl:value-of select="$curr/hl7:XPN.15"/></string>
                </xsl:if>
            </array>
        </xsl:if>
        <!-- optional -->
        <xsl:if test="$curr/hl7:XPN.4 or $curr/hl7:XPN.6 or $curr/hl7:XPN.14">
            <array key="suffix">
                <xsl:if test="$curr/hl7:XPN.4">
                    <string><xsl:value-of select="$curr/hl7:XPN.4"/></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XPN.6">
                    <string><xsl:value-of select="$curr/hl7:XPN.6"/></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XPN.14">
                    <string><xsl:value-of select="$curr/hl7:XPN.14"/></string>
                </xsl:if>
            </array>
        </xsl:if>
        <!-- optional -->
        <xsl:if test="$curr/hl7:XPN.5">
            <array key="prefix">
                <string><xsl:value-of select="$curr/hl7:XPN.5"/></string>
            </array>
        </xsl:if>
        <!-- required but not populated sometimes, so added a check -->
        <xsl:if test="$use!=''">
            <string key="use"><xsl:value-of select="$use"/></string>
        </xsl:if>
        <!-- all dates optional -->
        <xsl:if test="$curr/hl7:XPN.12 or $curr/hl7:XPN.13 or $curr/hl7:XPN.10">
            <map key="period">
                <xsl:if test="$curr/hl7:XPN.12">
                    <string key="start"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:XPN.12"/>
                        </xsl:call-template></string>
                </xsl:if>
                <xsl:if test="$curr/hl7:XPN.13">
                    <string key="end"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:XPN.13"/>
                        </xsl:call-template></string>
                </xsl:if>
                <!-- XPN.10 can be a start & end date, or just start date 
                     Haven't seen a case where it is both start & end date
                     so will just handle start date for now -->
                <xsl:choose>
                    <xsl:when test="$curr/hl7:XPN.10">
                        <string key="start"><xsl:call-template name="DateTime">
                                <xsl:with-param name="date" select="$curr/hl7:XPN.10"/>
                            </xsl:call-template></string>
                    </xsl:when>
                </xsl:choose>
            </map>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>