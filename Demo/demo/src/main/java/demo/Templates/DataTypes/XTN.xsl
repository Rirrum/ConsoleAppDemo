<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Handles telephone numbers, following FHIR-Converter
         DataType/XTN
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/>
    <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="XTN">
        <xsl:param name="curr"/>
        <xsl:if test="not($curr/hl7:XTN.7) and not($curr/hl7:XTN.12)
            and not($curr/hl7:XTN.3='Internet') and not(curr/hl7:XTN.3='X.400')">
            <string key="value"><xsl:value-of select="$curr/hl7:XTN.1"/></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XTN.3='Internet' or $curr/hl7:XTN.3='X.400'">
            <!-- added logic to avoid blank values (FHIR Converter just uses first
                 case and handles blank values behind the scene, maybe liquid property) -->
            <xsl:if test="$curr/hl7:XTN.4">
                <string key="value"><xsl:value-of select="$curr/hl7:XTN.4"/></string>
            </xsl:if>
            <xsl:if test="not($curr/hl7:XTN.4)">
                <string key="value"><xsl:value-of select="$curr/hl7:XTN.1"/></string>
            </xsl:if>
        </xsl:if>
        <xsl:if test="not($curr/hl7:XTN.3='Internet') and not(curr/hl7:XTN.3='X.400')
            and $curr/hl7:XTN.12">
            <!-- added logic to avoid blank values (FHIR Converter just uses first
                 case and handles blank values behind the scene, maybe liquid property)-->
            <xsl:if test="$curr/hl7:XTN.12">
                <string key="value"><xsl:value-of select="$curr/hl7:XTN.12"/></string>
            </xsl:if>
            <xsl:if test="not($curr/hl7:XTN.12)">
                <string key="value"><xsl:value-of select="$curr/hl7:XTN.1"/></string>
            </xsl:if>
        </xsl:if>
        <xsl:if test="$curr/hl7:XTN.2">
            <string key="use"><xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="'CodeSystem/TelecomUseCode'"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:XTN.2"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XTN.3">
            <string key="system"><xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="'CodeSystem/TelecomEquipmentType'"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:XTN.3"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template></string>
        </xsl:if>
        <xsl:if test="$curr/hl7:XTN.13 or $curr/hl7:XTN.14">
            <map key="period">
                <string key="start"><xsl:call-template name="DateTime">
                        <xsl:with-param name="date" select="$curr/hl7:XTN.13"/>
                    </xsl:call-template></string>
                <string key="end"><xsl:call-template name="DateTime">
                        <xsl:with-param name="date" select="$curr/hl7:XTN.14"/>
                    </xsl:call-template></string>
            </map>
        </xsl:if>
        <xsl:if test="$curr/hl7:XTN.18">
            <string key="rank"><xsl:value-of select="$curr/hl7:XTN.18"/></string>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>