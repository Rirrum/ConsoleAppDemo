<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:hl7="urn:hl7-org:v2xml">
  <xsl:output method="text" encoding="UTF-8"/>
  
  <!--
       
       FHIR Patient Resource as a re-usable mapping template
       
  -->
  
  <!-- <xsl:import href="../DataTypes/CX.xsl"/>
  <xsl:import href="../Functions/GetUUID.xsl"/>
  <xsl:import href="../DataTypes/DLN.xsl"/>
  <xsl:import href="../DataTypes/CWECodeableConceptRepeatable.xsl"/>
  <xsl:import href="../DataTypes/DRPeriod.xsl"/>
  <xsl:import href="../DataTypes/XPN.xsl"/>
  <xsl:import href="../DataTypes/CWECode.xsl"/>
  <xsl:import href="../DataTypes/XAD.xsl"/>
  <xsl:import href="../DataTypes/XTN.xsl"/>
  <xsl:import href="../DataTypes/CWECodeableConcept.xsl"/> -->
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/CX/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FCX%2Fread&amp;sv=1.0&amp;sig=RH4ciVt0d_S_P9ms9hXI8u5EKW64Qun0hv68iQF9oh0"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/GetUUID/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FGetUUID%2Fread&amp;sv=1.0&amp;sig=MzI0zkZUaSMRHQZIqwEOI3H6AODzpfU-9zPjaPFYOr4"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DLN/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FDLN%2Fread&amp;sv=1.0&amp;sig=cIFkyO2p1YsfcejCc0VnKDOgFBrPBWVgGnyZMOZCaac"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/CWECodeableConceptRepeatable/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FCWECodeableConceptRepeatable%2Fread&amp;sv=1.0&amp;sig=U_eeHo73V35cbcNff6UCdxHQe9D2yKzyIKvxezpdpFg"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DRPeriod/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FDRPeriod%2Fread&amp;sv=1.0&amp;sig=yEoMukVHrBvcTD70srwAjywXZ9oIoAeBJpHNJm4fSKg"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/XPN/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FXPN%2Fread&amp;sv=1.0&amp;sig=4aDM-5-l1xhgnJZRlT8EAWKRJRzxNx2dzjvSBePfqyU"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/CWECode/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FCWECode%2Fread&amp;sv=1.0&amp;sig=ZZOTT7WEX_Z6l0OMYWSWvFiKmp34kasbEQ6KkKF9Wkg"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/XAD/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FXAD%2Fread&amp;sv=1.0&amp;sig=ZpBMZNJ02U3NhODDOsKd7B0Vh1rPJAc1CDeBLYJfAxM"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/XTN/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FXTN%2Fread&amp;sv=1.0&amp;sig=o4UsZ_tQurkljncKGSHuUcGso8E7BMOoe2d1-K___tw"/>
  <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/CWECodeableConcept/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A39%3A45.9332587Z&amp;sp=%2Fmaps%2FCWECodeableConcept%2Fread&amp;sv=1.0&amp;sig=ZwTbRPu_RjvQam3zkjGbZiI7hToAadxp4155XIOtTOw"/>

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
          <xsl:if test="./hl7:PID/hl7:PID.2/hl7:CX.5">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.2"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:PID/hl7:PID.3">
            <xsl:if test="./hl7:CX.5"> 
              <xsl:call-template name="CX">
                <!-- pass current node in for-each loop -->
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
          
          <xsl:if test="./hl7:PID/hl7:PID.4/hl7:CX.5">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.4"/>
            </xsl:call-template>
          </xsl:if>
          
          <xsl:if test="./hl7:PID/hl7:PID.19">
            <map>
              <string key="value">
                <xsl:value-of select="./hl7:PID/hl7:PID.19"/>
              </string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">SB</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                  </map>
                </array>
              </map>
              <string key="system">http://hl7.org/fhir/sid/us-ssn</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./hl7:GT1/hl7:GT1.12">
            <map>
              <string key="value">
                <xsl:value-of select="./hl7:GT1/hl7:GT1.12"/>
              </string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">SB</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                    <string key="display">Social Beneficiary Identifier</string>
                  </map>
                </array>
              </map>
              <string key="system">http://hl7.org/fhir/sid/us-ssn</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./hl7:PID/hl7:PID.20">  
            <xsl:call-template name="DLN">
              <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.20"/>
            </xsl:call-template>
          </xsl:if>
          
          <!-- repeatable field -->
          <xsl:if test="./hl7:DB1/hl7:DB1.2 = 'PT' or ./hl7:DB1/hl7:DB1.2/hl7:CWE.1 = 'PT'">
            <xsl:for-each select="./hl7:DB1/hl7:DB1.3">
              <xsl:call-template name="CX">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:if>
          
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.2">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="."/>
            </xsl:call-template>
          </xsl:for-each>
          
          <!-- repeatable field -->
          <xsl:for-each select="./*[$insurance]/hl7:IN1/hl7:IN1.49">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="."/>              
            </xsl:call-template>
          </xsl:for-each>
          
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.19">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="."/>
            </xsl:call-template>
          </xsl:for-each>
          
          <!-- repeatable field -->
          <xsl:for-each select="./*[$insurance]/hl7:IN2/hl7:IN2.1">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="."/>
            </xsl:call-template>
          </xsl:for-each>
          
          <xsl:if test="./*[$insurance]/hl7:IN2/hl7:IN2.2">
            <map>
              <string key="value"><xsl:value-of select="./*[$insurance]/hl7:IN2/hl7:IN2.2"/></string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">SS</string>
                    <string key="display">Social Security Number</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                  </map>
                </array>
              </map>
              <string key="system">http://hl7.org/fhir/sid/us-ssn</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./*[$insurance]/hl7:IN2/hl7:IN2.6">
            <map>
              <string key="value"><xsl:value-of select="./*[$insurance]/hl7:IN2/hl7:IN2.6"/></string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">MC</string>
                    <string key="display">Patient's Medicare number</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                  </map>
                </array>
              </map>
              <string key="system">http://hl7.org/fhir/sid/us-medicare</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./*[$insurance]/hl7:IN2/hl7:IN2.8">
            <map>
              <string key="value"><xsl:value-of select="./*[$insurance]/hl7:IN2/hl7:IN2.8"/></string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">MA</string>
                    <string key="display">Patient Medicaid number</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                  </map>
                </array>
              </map>
              <!-- this needs to be replaced -->
              <string key="system">http://example.com/v2-to-fhir-converter/sid/us-medicaid</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./*[$insurance]/hl7:IN2/hl7:IN2.10">
            <map>
              <string key="value"><xsl:value-of select="./*[$insurance]/hl7:IN2/hl7:IN2.10"/></string>
              <map key="type">
                <array key="coding">
                  <map>
                    <string key="code">MI</string>
                    <string key="display">Military ID number</string>
                    <string key="system">http://terminology.hl7.org/CodeSystem/v2-0203</string>
                  </map>
                </array>
              </map>
              <!-- this needs to be replaced -->
              <string key="system">http://example.com/v2-to-fhir-converter/sid/us-military</string>
            </map>
          </xsl:if>
          
          <xsl:if test="./*[$insurance]/hl7:IN2/hl7:IN2.61">
            <xsl:call-template name="CX">
              <xsl:with-param name="curr" select="./*[$insurance]/hl7:IN2/hl7:IN2.61"/>
            </xsl:call-template>
          </xsl:if> 
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
          
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.3">
            <map>
              <xsl:call-template name="XPN">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </map>
          </xsl:for-each>
          
          <!-- repeatable field -->
          <xsl:for-each select="./*[$insurance]/hl7:IN1/hl7:IN1.16">
            <map>
              <xsl:call-template name="XPN">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </map>
          </xsl:for-each>
          
          <!-- repeatable field, FHIR Converter has this as for IN2_6.7.repeats
               which doesn't make sense as IN2.7 is the XPN data that repeats -->
          <xsl:for-each select="./*[$insurance]/hl7:IN2/hl7:IN2.7">
            <map>
              <xsl:call-template name="XPN">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </map>
          </xsl:for-each>
          
          <xsl:if test="./hl7:CON">
            <map>
              <xsl:call-template name="XPN">
                <xsl:with-param name="curr" select="./hl7:CON"/>
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
        <xsl:if test="not(./hl7:PID/hl7:PID.7)">
          <xsl:if test="./hl7:GT1/hl7:GT1.8">
            <string key="birthDate"><xsl:call-template name="DateTime">
                <xsl:with-param name="date" select="substring(./hl7:GT1/hl7:GT1.8,0,9)"/>
              </xsl:call-template></string>
          </xsl:if>
          <xsl:if test="not(./hl7:GT1/hl7:GT1.8) and ./*[$insurance]/hl7:IN1/hl7:IN1.18">
            <string key="birthDate"><xsl:call-template name="DateTime">
                <xsl:with-param name="date" select="substring(./*[$insurance]/hl7:IN1/hl7:IN1.18,0,9)"/>
              </xsl:call-template></string>
          </xsl:if>
        </xsl:if>
        
        <!-- gender -->
        <xsl:if test="./hl7:PID/hl7:PID.8">
          <string key="gender"><xsl:call-template name="CWECode">
              <xsl:with-param name="curr" select="./hl7:PID/hl7:PID.8"/>
              <xsl:with-param name="mapping" select="'CodeSystem/Gender'"/>
            </xsl:call-template></string>
        </xsl:if>
        <xsl:if test="not(./hl7:PID/hl7:PID.8) and ./hl7:GT1/hl7:GT1.9">
          <string key="gender"><xsl:call-template name="CWECode">
              <xsl:with-param name="curr" select="./hl7:GT1/hl7:GT1.9"/>
              <xsl:with-param name="mapping" select="'CodeSystem/Gender'"/>
            </xsl:call-template></string>
        </xsl:if>
        <xsl:if test="not(./hl7:PID/hl7:PID.8) and not(./hl7:GT1/hl7:GT1.9) and ./*[$insurance]/hl7:IN1/hl7:IN1.43">
          <string key="gender"><xsl:call-template name="CWECode">
              <xsl:with-param name="curr" select="./*[$insurance]/hl7:IN1/hl7:IN1.43"/>
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
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.5">
            <map>
              <xsl:call-template name="XAD">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </map>
          </xsl:for-each>
          <xsl:for-each select="./*[$insurance]/hl7:IN1/hl7:IN1.19">
            <map>
              <xsl:call-template name="XAD">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
            </map>
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
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.6">
            <map>
              <xsl:call-template name="XTN">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
              <string key="use">home</string>
            </map>
          </xsl:for-each>
          <!-- repeatable field -->
          <xsl:for-each select="./hl7:GT1/hl7:GT1.7">
            <map>
              <xsl:call-template name="XTN">
                <xsl:with-param name="curr" select="."/>
              </xsl:call-template>
              <string key="use">work</string>
            </map>
          </xsl:for-each>
          <!-- repeatable field -->
          <xsl:for-each select="./*[$insurance]/hl7:IN2/hl7:IN2.63">
            <!-- added this as sample message had an XTN segment missing value,
                 may have to add this check to all calls of XTN to avoid blank 
                 telecom numbers -->
            <xsl:if test="./XTN.1">
              <map>
                <xsl:call-template name="XTN">
                  <xsl:with-param name="curr" select="."/>
                </xsl:call-template>
              </map>
            </xsl:if>
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
            <xsl:when test="not(./hl7:PID/hl7:PID.15)">
              <map>
                <map key="language">
                  <xsl:call-template name="CWECodeableConcept">
                    <xsl:with-param name="curr" select="./hl7:GT1/hl7:GT1.36"/>
                    <xsl:with-param name="mapping" select="'CodeSystem/Language'"/>
                  </xsl:call-template>
                </map>
                <string key="preferred">true</string>
              </map>
            </xsl:when>
            <xsl:when test="./*[$insurance]/hl7:IN2/hl7:IN2.34">
              <map>
                <map key="language">
                  <xsl:call-template name="CWECodeableConcept">
                    <xsl:with-param name="curr" select="./*[$insurance]/hl7:IN2/hl7:IN2.34"/>
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
          <xsl:if test="not(./hl7:PID/hl7:PID.16) and ./hl7:GT1/hl7:GT1.30">
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
          <xsl:if test="not(./hl7:PID/hl7:PID.30)">
            <xsl:if test="./hl7:GT1/hl7:GT1.24">
              <string key="deceasedDateTime">
                <xsl:call-template name="DateTime">
                  <xsl:with-param name="date" select="./hl7:GT1/hl7:GT1.24"/>
                </xsl:call-template></string>
            </xsl:if>
            <xsl:if test="./hl7:GT1/hl7:GT1.25 and not(./hl7:GT1/hl7:GT1.24)">
              <string key="deceasedDateTime">
                <xsl:call-template name="DateTime">
                  <xsl:with-param name="date" select="./hl7:GT1/hl7:GT1.25"/>
                </xsl:call-template></string>
            </xsl:if>
          </xsl:if>
          <xsl:if test="./hl7:PID/hl7:PID.30">
            <string key="deceasedBoolean"><xsl:call-template name="codeInfo">
                <xsl:with-param name="systemParam" select="'CodeSystem/Yes_No'"/>
                <xsl:with-param name="codeParam" select="./hl7:PID/hl7:PID.30"/>
                <xsl:with-param name="whichParam" select="'code'"/>
              </xsl:call-template></string>
          </xsl:if>
        </xsl:if>
        
        <!-- meta/security -->
        <map key="meta">
          <xsl:if test="./hl7:PID/hl7:PID.33">
            <string key="lastUpdated">
              <xsl:call-template name="DateTime">
                <xsl:with-param name="date" select="./hl7:PID/hl7:PID.33"/>
              </xsl:call-template></string>
          </xsl:if>
          <array key="security">
            <xsl:for-each select="./hl7:ARV">
              <!-- this is hardcoded to select the first ARV node, need to find a better
                   way to grab the first ARV node after the PID segment -->
              <xsl:if test="position()=1">
                <xsl:if test="./hl7:ARV.2">
                  <map>
                    <!-- Assumes that ARV.2 will have nested CNE section, may have to support case where this doesn't exist -->
                    <xsl:choose>
                      <xsl:when test="./hl7:ARV.2/hl7:CNE.1 = 'A' or ./hl7:ARV.2/hl7:CNE.1 = 'U'">
                        <string key="code">LABEL</string>
                        <string key="display">assign security label</string>
                        <string key="system">http://terminology.hl7.org/CodeSystem/v3-ActCode</string>
                      </xsl:when>
                      <xsl:when test="./hl7:ARV.2/hl7:CNE.1 = 'X'">
                        <string key="code">PERSISTLABEL</string>
                        <string key="display">persist security label</string>
                        <string key="system">http://terminology.hl7.org/CodeSystem/v3-ActCode</string>
                      </xsl:when>
                      <xsl:when test="./hl7:ARV.2/hl7:CNE.1 = 'D'">
                        <string key="code">DELETELABEL</string>
                        <string key="display">delete security label</string>
                        <!-- needs to be replaced -->
                        <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/additional-security-label</string>
                      </xsl:when>
                    </xsl:choose>
                  </map>
                </xsl:if>
                
                <xsl:if test="./hl7:ARV.3">
                  <xsl:call-template name="CWECodeableConceptRepeatable">
                    <xsl:with-param name="curr" select="./hl7:ARV.3"/>
                    <xsl:with-param name="mapping" select="'CodeSystem/AccessRestrictionValue'"/>
                  </xsl:call-template>
                </xsl:if>
                
                <!-- repeatable field -->
                <xsl:for-each select="./hl7:ARV.4">
                  <xsl:call-template name="CWECodeableConceptRepeatable">
                    <xsl:with-param name="curr" select="."/>
                    <xsl:with-param name="mapping" select="'CodeSystem/AccessRestrictionReason'"/>
                  </xsl:call-template>
                </xsl:for-each>
                
                <!-- repeatable field -->
                <xsl:for-each select="./hl7:ARV.5">
                  <map>
                    <!-- replace this link -->
                    <string key="system">http://example.com/v2-to-fhir-converter/CodeSystem/additional-security-label</string>
                    <string key="code">special-access-restriction-instructions</string>
                    <string key="display"><xsl:value-of select="."/></string>
                  </map>
                </xsl:for-each>
                
                <xsl:if test="./hl7:ARV.6">
                  <map>
                    <array key="extension">
                      <map>
                        <string key="url">http://hl7.org/fhir/uv/v2mappings/StructureDefinition/access-restriction-range</string>
                        <map key="valuePeriod"><xsl:call-template name="DRPeriod">
                            <xsl:with-param name="curr" select="./hl7:ARV.6"/>
                          </xsl:call-template></map>
                      </map>
                    </array>
                  </map>
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
          </array>
        </map>
        
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
          <!-- this field is repeatable, FHIR-Converter only takes the first -->
          <xsl:for-each select="./hl7:ROL/hl7:ROL.4">
            <xsl:if test="position()=1">
              <map>
                <string key="reference">Organization/<xsl:call-template name="GetUUID">
                    <xsl:with-param name="curr" select="."/>
                  </xsl:call-template></string>
              </map>
            </xsl:if>
          </xsl:for-each>
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
          <!-- then handle guarantor contacts -->
          <xsl:for-each select="./hl7:GT1">
            <map>
              <map key="name">
                <xsl:call-template name="XPN">
                  <xsl:with-param name="curr" select="./hl7:GT1.16"/>
                </xsl:call-template>
              </map>
              <map key="address">
                <xsl:call-template name="XAD">
                  <xsl:with-param name="curr" select="./hl7:GT1.17"/>
                </xsl:call-template>
              </map>
              <array key="telecom">
                <xsl:for-each select="./hl7:GT1.18">
                  <map>
                    <xsl:call-template name="XTN">
                      <xsl:with-param name="curr" select="."/>
                    </xsl:call-template>
                  </map>
                </xsl:for-each>
              </array>
              <!-- grabbed from FHIR Converter -->
              <xsl:if test="./hl7:GT1.16">
                <array key="relationship">
                  <map>
                    <array key="coding">
                      <map>
                        <string key="code">E</string>
                        <string key="display">Employer</string>
                        <string key="system">http://terminology.hl7.org/CodeSystem/v2-0131</string>
                      </map>
                    </array>
                  </map>
                </array>
              </xsl:if>
              <xsl:if test="./hl7:GT1.31 or ./hl7:GT1.32">
                <map key="period">
                  <xsl:if test="./hl7:GT1.31">
                    <string key="start"><xsl:call-template name="DateTime">
                        <xsl:with-param name="date" select="./hl7:GT1.31"/>
                      </xsl:call-template></string>
                  </xsl:if>
                  <xsl:if test="./hl7:GT1.32">
                    <string key="end"><xsl:call-template name="DateTime">
                        <xsl:with-param name="date" select="./hl7:GT1.32"/>
                      </xsl:call-template></string>
                  </xsl:if>
                </map>
              </xsl:if>
              <xsl:if test="./hl7:GT1.51">
                <map key="organization">
                  <string key="reference">Organization/<xsl:call-template name="GetUUID">
                      <xsl:with-param name="curr" select="./hl7:GT1.51"/>
                    </xsl:call-template></string>
                </map>
              </xsl:if>
            </map>
            <xsl:for-each select="./hl7:GT1.4">
              <map>
                <map key="name">
                  <map key="name">
                    <xsl:call-template name="XPN">
                      <xsl:with-param name="curr" select="."/>
                    </xsl:call-template>
                  </map>
                  <array key="relationship">
                    <map>
                      <array key="coding">
                        <map>
                          <string key="code">N</string>
                          <string key="display">Next of Kin</string>
                          <string key="system">http://terminology.hl7.org/CodeSystem/v2-0131</string>
                        </map>
                      </array>
                    </map>
                  </array>
                </map>
              </map>
            </xsl:for-each>
            <xsl:if test="./hl7:GT1.45 or ./hl7:GT1.46">
              <map>
                <xsl:for-each select="./hl7:GT1.45">
                  <xsl:if test="position()=1">
                    <map key="name">
                      <xsl:call-template name="XPN">
                        <xsl:with-param name="curr" select="."/>
                      </xsl:call-template>
                    </map>
                  </xsl:if>
                </xsl:for-each>
                <xsl:if test="./hl7:GT1.46">
                  <array key="telecom">
                    <xsl:for-each select="./hl7:GT1.46">
                      <map>
                        <xsl:call-template name="XTN">
                          <xsl:with-param name="curr" select="."/>
                        </xsl:call-template>
                      </map>
                    </xsl:for-each>
                  </array>
                </xsl:if>
              </map>
            </xsl:if>
          </xsl:for-each>
          <!-- finally handle CTD contacts - this message segment
               is not part of ADT_A01 messages but could be needed 
               in the future -->
          <xsl:for-each select="./hl7:CTD">
            <map>
              <map key="name">
                <xsl:call-template name="XPN">
                  <xsl:with-param name="curr" select="./hl7:CTD.2"/>
                </xsl:call-template>
              </map>
              <map key="address">
                <xsl:call-template name="XAD">
                  <xsl:with-param name="curr" select="./hl7:CTD.3"/>
                </xsl:call-template>
              </map>
              <array key="telecom">
                <xsl:for-each select="./hl7:CTD.5">
                  <map>
                    <xsl:call-template name="XTN">
                      <xsl:with-param name="curr" select="."/>
                    </xsl:call-template>
                  </map>
                </xsl:for-each>
              </array>
            </map>
          </xsl:for-each>
          <!-- fill extra contacts -->
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